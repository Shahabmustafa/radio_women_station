import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_radio/const/string.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(h * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'THE VOCIE OF WOMEN',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                content1,
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: h * 0.03,
              ),
              Text(
                'OUR VISION ',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                content2,
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: h * 0.03,
              ),
              Text(
                'OUR MISSION',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                content3,
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: h * 0.03,
              ),
              Text(
                'CORE VALUES',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                content4,
                textAlign: TextAlign.justify,
              ),

              SizedBox(
                height: h * 0.03,
              ),
              Text(
                'Address',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                content5,
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: h * 0.03,
              ),
              Text(
                'Phone Number',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                content6,
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: h * 0.03,
              ),

              Text(
                'Email',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                content7,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
