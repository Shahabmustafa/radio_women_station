import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:women_radio/const/color.dart';
import 'package:women_radio/const/list.dart';
import 'package:women_radio/controller/home_controller.dart';
import 'package:women_radio/myaudio_handler.dart';
import 'package:women_radio/view/about_screen.dart';
import 'package:women_radio/view/live_stream.dart';
import 'package:women_radio/view/webview_screen.dart';
import 'package:women_radio/widget/card_widget.dart';

import 'view_pdf_screen.dart';
import 'witness_screen.dart';

class HomeScreen extends StatefulWidget {
  MyAudioHandler audioHandler = MyAudioHandler();
  HomeScreen({super.key, required this.audioHandler});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).width;
    var controller = Get.put(HomeController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.only(left: 12, right: 12, top: 30, bottom: 12),
          child: Column(
            children: [
              // Text(
              //   'Women Radio Station'.toUpperCase(),
              //   style: GoogleFonts.inter(
              //       fontSize: 18, color: redColor, fontWeight: FontWeight.w800),
              // ),
              // SizedBox(
              //   height: h * 0.03,
              // ),
              //carousel slid
              Obx(
                () => Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          initialPage: 0,
                          height: 190,
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                          onPageChanged: (index, reson) {
                            controller.activeIndex.value = index;
                          }),
                      items: [0, 1, 2, 3].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return SizedBox(
                              width: w,
                              child: Image.asset(
                                slideImageList[i],
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    buildIndicator(controller.activeIndex.value),
                  ],
                ),
              ),
              SizedBox(
                height: h * 0.05,
              ),
              Text(
                'Women Radio FM 91.7'.toUpperCase(),
                style: GoogleFonts.inter(
                    fontSize: 20, color: redColor, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                textAlign: TextAlign.center,
                'Nigeria\'s only Radio Station For Women and their Families.',
                style: GoogleFonts.poppins(color: redColor, fontSize: 14),
              ),

              //buttons
              SizedBox(
                height: h * 0.03,
              ),
              Expanded(
                child: GridView.builder(
                    itemCount: listButtonLabel.length,
                    shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            mainAxisExtent: 110),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          switch (index) {
                            case 0:
                              Get.to(const AboutScreen());
                              break;
                            case 1:
                              Get.to(LiveStream(
                                  audioHandler: widget.audioHandler));
                              break;
                            case 2:
                              Get.to(const PdfViewScreen());
                              break;
                            case 3:
                              const url =
                                  'https://podcasters.spotify.com/pod/show/wfm917';
                              Get.to(WebViewApp(
                                url: url,
                                title: 'Podcast',
                              ));

                              break;
                            case 4:
                              Get.to(const WitnessScreen());
                              break;
                            case 5:
                              print('case 6');
                              const url = 'https://wfm917.com/category/news/';
                              Get.to(WebViewApp(title: 'News', url: url));
                              break;
                            case 6:
                              const url = 'https://forms.office.com/Pages/ResponsePage.aspx?id=tkLbhbBx-kGED6UlWjov5wIHiXFFq3dFmCNhnZCR5RFUNkQxMFhTODRYREdOSEM3Q0cxRExDS082Ty4u';
                              Get.to(WebViewApp(
                                title: 'Membership',
                                url: url,
                              ));

                              break;
                            case 7:
                              const url = 'https://twitter.com/wfm917';
                              Get.to(WebViewApp(
                                title: 'Twitter',
                                url: url,
                              ));

                              break;
                            case 8:
                              const url = 'https://www.instagram.com/wfm917/';
                              Get.to(WebViewApp(
                                title: 'Instagram',
                                url: url,
                              ));

                              break;
                            case 9:
                              const url =
                                  'https://www.linkedin.com/company/wfm-91.7/';
                              Get.to(WebViewApp(
                                title: 'Linkedin',
                                url: url,
                              ));

                              break;
                            case 10:
                              const url = 'https://www.facebook.com/wfm917';
                              Get.to(WebViewApp(
                                title: 'Facebook',
                                url: url,
                              ));

                              break;
                          }
                        },
                        child: cardWidget(
                            icon: listButtonIcon[index],
                            title: listButtonLabel[index]),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(int activeIndex) => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 4,
        effect: CustomizableEffect(
            dotDecoration: DotDecoration(
              width: 16,
              height: 4,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              dotBorder: const DotBorder(color: redColor, width: 2),
            ),
            activeDotDecoration: DotDecoration(
              width: 16,
              height: 4,
              color: redColor,
              borderRadius: BorderRadius.circular(10),
              dotBorder: const DotBorder(color: redColor, width: 2),
            )),
      );
}
