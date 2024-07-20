import 'package:flutter/material.dart';
import 'package:golden_wave/constants/my_colors.dart';

class CreativeWriting extends StatelessWidget {
  const CreativeWriting({super.key});

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
                'Creative writing',
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
                'We strive to provide distinguished and engaging content that effectively delivers the intended message to the target audience. Our creative writing services include poetry and prose composition, scriptwriting, story and novel writing, biography writing, and ad writing.',
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
        'assets/images/writing.png',
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
