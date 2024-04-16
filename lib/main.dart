import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:women_radio/const/color.dart';
import 'package:women_radio/view/home.dart';
import 'package:women_radio/view/live_stream.dart';
import 'package:women_radio/view/webview_screen.dart';

import 'myaudio_handler.dart';

// Create an instance of MyAudioHandler
MyAudioHandler _audioHandler = MyAudioHandler();
void main() async {
  //Ensure that Flutter binding is initalized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize AudioService with MyAudioHandler as the audio handler
  _audioHandler = await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.example.women_radio',
      androidNotificationChannelName: 'Audio Playback',
      androidNotificationOngoing: true,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: redColor, // Change the color as needed
      ),
    );
    return GetMaterialApp(
        title: 'Radio Women Station',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
                systemOverlayStyle:
                    SystemUiOverlayStyle(statusBarColor: redColor),
                color: redColor,
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
                iconTheme: IconThemeData(
                  color: Colors.white,
                )),
            iconTheme: const IconThemeData(
              color: redColor,
            )),
        home: HomeScreen(
          audioHandler: _audioHandler,
        ));
  }
}
