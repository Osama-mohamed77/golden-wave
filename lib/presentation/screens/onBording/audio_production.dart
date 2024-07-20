import 'package:flutter/material.dart';
import 'package:golden_wave/constants/my_colors.dart';

class AudioProduction extends StatelessWidget {
  const AudioProduction({super.key});

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
                'Audio production',
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
                'We ensure an exceptional audio experience with the best quality by using unique technologies and carefully selecting voice artists under specialized team supervision. Our services include audio engineering and effects, audiobook recording, poetry and prose recording, dubbing, podcast recording, music and artistic works recording, wedding zaffa recording, music distribution, voice-over, IVR, and composing cinematic music.',
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
        'assets/images/Audio.png',
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
