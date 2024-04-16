import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_radio/controller/witness_controller.dart';
import 'package:women_radio/widget/custom_textfield.dart';
import 'package:women_radio/widget/round_button.dart';

import '../const/color.dart';

class WitnessScreen extends StatefulWidget {
  const WitnessScreen({super.key});

  @override
  State<WitnessScreen> createState() => _WitnessScreenState();
}

class _WitnessScreenState extends State<WitnessScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(WitnessController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        title: const Text(
          'Eye Witness',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Write Your Eye Witness',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    customTextField(
                      label: 'Name',
                      hint: 'Enter your name',
                      isPass: false,
                      controller: controller.nameController,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    customTextField(
                      label: 'Phone Number',
                      hint: 'Enter your Phone Number',
                      isPass: false,
                      controller: controller.ageController,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    customTextField(
                      label: 'Email',
                      hint: 'Enter your email',
                      isPass: false,
                      controller: controller.emailController,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // customTextField(
                    //   label: 'Address',
                    //   hint: 'Enter your Address',
                    //   isPass: false,
                    //   controller: controller.addressController,
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    GestureDetector(
                      onTap: (){
                        _selectDate(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    customTextField(
                      label: 'Subject',
                      hint: 'Enter your Subject',
                      isPass: false,
                      controller: controller.subController,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    customTextField(
                      label: 'Description',
                      hint: 'Description',
                      maxLine: 5,
                      isPass: false,
                      controller: controller.desController,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Obx(
                () => Container(
                  padding: const EdgeInsets.only(left: 10),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(controller.name.value.isNotEmpty
                          ? controller.name.value
                          : 'Upload file'),
                      InkWell(
                        onTap: () {
                          controller.pickFile();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 97,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Color(0xffE4E4E4),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: const Text('Browse File'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(
                () => RoundButton(
                  loading: controller.isLoading.value,
                  title: 'Send',
                  onTap: () {
                    // Validate the form
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, perform actions or submit data\

                      controller.sendingEmail(
                          filePath: controller.pickedFile!,
                          name: controller.nameController.text,
                          age: controller.ageController.text,
                          address: controller.addressController.text,
                          subject: controller.subController.text,
                          des: controller.desController.text,
                          date:
                              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
