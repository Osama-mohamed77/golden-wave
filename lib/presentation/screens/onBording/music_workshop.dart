import 'package:flutter/material.dart';
import 'package:golden_wave/constants/my_colors.dart';

class MusicWorkshop extends StatelessWidget {
  const MusicWorkshop({super.key});

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
                'Music workshop',
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
                "We view music education as an exciting and inspiring journey. Our team of experienced professionals provides expertise in various areas, from learning instruments to music production and arrangement. We are committed to offering a unique learning experience tailored to your individual needs. Whether you’re a beginner or have prior experience, our services are designed to help you achieve your musical goals. Our aim is to guide you in reaching your artistic aspirations.",
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
        'assets/images/Music.png',
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
