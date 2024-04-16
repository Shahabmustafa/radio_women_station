import 'package:flutter/material.dart';
import 'package:women_radio/const/color.dart';

// ignore: must_be_immutable
class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  Color? btnColor;
  Color? textColor;
  RoundButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.btnColor,
      this.textColor,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
            color: btnColor ?? redColor,
            borderRadius: BorderRadius.circular(6)),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                )
              : Text(
                  title,
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: 18,
                  ),
                ),
        ),
      ),
    );
  }
}
