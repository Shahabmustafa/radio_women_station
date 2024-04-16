// import necessary packages

import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

// MyAudioHandler class that extends BaseAudioHandler with QueueHandler and SeekHandler

class MyAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  //create an instance of the AudioPlayer class from just_audio package
  AudioPlayer audioPlayer = AudioPlayer();

  final _mediaItemController = StreamController<MediaItem?>.broadcast();
  Stream<MediaItem?> get mediaItemx => _mediaItemController.stream;

  final _playingController = StreamController<bool>.broadcast();
  Stream<bool> get playing => _playingController.stream;

  // Broadcast the current playback state based on the received PlaybackEvent

  void broadcastState(PlaybackEvent event) {
    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (audioPlayer.playing) MediaControl.pause else MediaControl.play,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[audioPlayer.processingState]!,
        playing: audioPlayer.playing,
        updatePosition: audioPlayer.position,
        bufferedPosition: audioPlayer.bufferedPosition,
        speed: audioPlayer.speed,
        queueIndex: event.currentIndex,
      ),
    );
  }

  Future<void> setupAudioPlayer() async {
    try {
      await audioPlayer.setAudioSource(AudioSource.uri(
          Uri.parse("http://s28.myradiostream.com:11618/listen.mp3")));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  // Play function to start playback
  @override
  Future<void> play() async => audioPlayer.play();

  // Pause function to pause playback
  @override
  Future<void> pause() async => audioPlayer.pause();

  // seek function to change the playback position
  @override
  Future<void> seek(Duration position) => audioPlayer.seek(position);

  // skip to a specific item in the queue and start playback
  @override
  Future<void> skipToQueueItem(int index) async {
    await audioPlayer.seek(Duration.zero, index: index);
    play();
  }

  // skip to next item in the queue
  @override
  Future<void> skipToNext() async => audioPlayer.seekToNext();

  // skip to previous item in the queue
  @override
  Future<void> skipToPrevious() async => audioPlayer.seekToPrevious();

// Assuming audioPlayer is an instance of AudioPlayer
  bool isPlaying() {
    return audioPlayer.playing;
  }

  // Assuming you have a method to get the speed stream
  Stream<double> speedStream() {
    return audioPlayer.speedStream;
  }

  Stream<double> volumeStream() {
    return audioPlayer.volumeStream;
  }

  @override
  Future<void> setSpeed(double speed) async {
    await audioPlayer.setSpeed(speed);
  }

  Future<void> setVolume(double volume) async {
    await audioPlayer.setVolume(volume);
  }

  void isBroadCasting() {
    audioPlayer.playbackEventStream.listen(broadcastState);
  }
}
