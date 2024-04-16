import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_radio/const/color.dart';

Widget customTextField(
    {String? label, String? hint, controller, isPass, maxLine = 1}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label!,
        style: GoogleFonts.openSans(fontSize: 13, fontWeight: FontWeight.w600),
      ),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        controller: controller,
        maxLines: maxLine,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          }
          return null;
        },
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: redColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: redColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: redColor),
          ),
        ),
      )
    ],
  );
}
