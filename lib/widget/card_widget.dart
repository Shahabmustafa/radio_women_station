import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/color.dart';

Widget cardWidget({icon, title}) {
  return Container(
    alignment: Alignment.center,
    decoration:
        BoxDecoration(color: redColor, borderRadius: BorderRadius.circular(10)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Color(0xffeb494c), shape: BoxShape.circle),
          child: SvgPicture.asset(
            icon,
            height: 27,
            width: 27,
            fit: BoxFit.contain,
            color: Colors.white,
          ),
        ),
        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
          ),
        )
      ],
    ),
  );
}
