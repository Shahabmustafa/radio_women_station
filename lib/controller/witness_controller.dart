import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:women_radio/myaudio_handler.dart';
import 'package:women_radio/view/home.dart';

class WitnessController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController subController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  MyAudioHandler audioHandler = MyAudioHandler();
  File? pickedFile;
  var name = ''.obs;
  var isLoading = false.obs;

  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles();

      if (result != null) {
        pickedFile = File(result.files.first.path!); // Corrected line
        name.value = result.files.first.name;
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  //send data

  Future<void> sendingEmail(
      {filePath, name, age, address, subject, des, date}) async {
    String data =
        'Name : $name\nAge : $age\nDate: $date\nAddress : $address\n\n\n$des';
    isLoading(true);
    // change your email here
    String username = 'kashif900900@gmail.com';
    // change your password here
    String password = 'zfpmtnvjspnzibaq';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Women Radio Station')
      ..recipients.add('shahabmustafa57@gmail.com')
      ..subject = subject
      ..text = data
      ..attachments.add(FileAttachment(filePath));

    try {
      await send(message, smtpServer).then((value) => Get.offAll(HomeScreen(
            audioHandler: audioHandler,
          )));
      isLoading(false);

      Get.snackbar('successful', 'Email sent successfully',
          colorText: Colors.white, backgroundColor: const Color(0xffeb494c));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    isLoading(false);
  }
}
