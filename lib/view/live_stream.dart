import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:women_radio/const/image.dart';

import '../myaudio_handler.dart';

class LiveStream extends StatefulWidget {
  // Instance of MyAudioHandler for managing audio playback
  final MyAudioHandler audioHandler;

  // Constructor to initialise with an instance of MyAudioHandler
  const LiveStream({super.key, required this.audioHandler});

  @override
  State<LiveStream> createState() => _LiveStreamState();
}

class _LiveStreamState extends State<LiveStream> {
  // List to store MediaItems representing songs
  List<MediaItem> songs = [];

  @override
  void initState() {
    super.initState();
    widget.audioHandler.setupAudioPlayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (widget.audioHandler.isPlaying()) {
      widget.audioHandler.play();
      widget.audioHandler.isBroadCasting();
    } else {
      widget.audioHandler.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Stream"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(img6), fit: BoxFit.cover)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    _controlButtons(audioHandler: widget.audioHandler),
                    _playbackControlButton(audioHandler: widget.audioHandler),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _playbackControlButton({required MyAudioHandler audioHandler}) {
    return IconButton(
      iconSize: 64,
      onPressed: () {
        if (audioHandler.isPlaying()) {
          widget.audioHandler.pause();
        } else {
          widget.audioHandler.play();
        }
        setState(() {});
      },
      icon: Icon(
        audioHandler.isPlaying() ? Icons.pause : Icons.play_arrow,
        color: Colors.white,
      ),
    );
  }

  Widget _controlButtons({required MyAudioHandler audioHandler}) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      StreamBuilder(
          stream: widget.audioHandler.speedStream(),
          builder: (context, snapshot) {
            return Row(children: [
              const Icon(
                Icons.speed,
                color: Colors.white,
              ),
              Slider(
                  min: 1,
                  max: 3,
                  value: snapshot.data ?? 1,
                  divisions: 3,
                  onChanged: (value) async {
                    await audioHandler.setSpeed(value);
                  })
            ]);
          }),
      StreamBuilder(
          stream: audioHandler.volumeStream(),
          builder: (context, snapshot) {
            return Row(children: [
              const Icon(
                Icons.volume_up,
                color: Colors.white,
              ),
              Slider(
                  min: 0,
                  max: 3,
                  value: snapshot.data ?? 1,
                  divisions: 4,
                  onChanged: (value) async {
                    await audioHandler.setVolume(value);
                  })
            ]);
          }),
    ]);
  }
}


/**
 * import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

import '../services/my_audio_handler.dart';

class HomePage extends StatefulWidget {
  final MyAudioHandler audioHandler;

  const HomePage({Key? key, required this.audioHandler}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.audioHandler.initSongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music App"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<MediaItem?>(
            stream: widget.audioHandler.mediaItem,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Container();
              }
              MediaItem currentItem = snapshot.data!;
              return ListTile(
                title: Text(currentItem.title ?? ''),
                subtitle: Text(currentItem.artist ?? ''),
              );
            },
          ),
          StreamBuilder<bool>(
            stream: widget.audioHandler.playing,
            builder: (context, snapshot) {
              final isPlaying = snapshot.data ?? false;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.skip_previous),
                    onPressed: () {
                      widget.audioHandler.skipToPrevious();
                    },
                  ),
                  IconButton(
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    onPressed: () {
                      setState(() {});
                      if (isPlaying) {
                        widget.audioHandler.pause();
                      } else {
                        widget.audioHandler.play();
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.forest),
                    onPressed: () {
                      widget.audioHandler.stop();
                      setState(() {});
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

 */