import 'package:flutter/material.dart';
import 'package:golden_wave/constants/my_colors.dart';

class MediaQualification extends StatelessWidget {
  const MediaQualification({super.key});
  Widget title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = MediaQuery.of(context).size.width;
              double responsiveFontSize =
                  screenWidth * 0.08; // Adjust this factor as needed

              return Text(
                'Media qualification',
                style: TextStyle(
                  fontSize: responsiveFontSize,
                  fontFamily: 'inter',
                  color: MyColors.myYellow,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget details(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 100.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = MediaQuery.of(context).size.width;
          double responsiveFontSize =
              screenWidth * 0.05; // Adjust this factor as needed

          return Center(
            child: SizedBox(
              width: screenWidth, // Adjust the width as needed
              child: Text(
                "We understand that media plays a fundamental role in shaping society's perspectives and influencing it. Therefore, we provide specialized training programs for individuals who wish to develop their media skills through our team of experts and academics in all media fields. We offer training courses covering various aspects of media production: Preparation, Presentation, Hosting, Editing, Audio Engineering, and Directing.",
                style: TextStyle(
                    fontSize: responsiveFontSize,
                    fontFamily: 'inter',
                    color: MyColors.myWhite),
                textAlign: TextAlign.left,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget backgroundImage() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Image.asset(
        'assets/images/Media.png',
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Stack(
        children: [
          backgroundImage(),
          Column(
            children: [
              title(context),
              details(context),
            ],
          )
        ],
      ),
    );
  }
}
