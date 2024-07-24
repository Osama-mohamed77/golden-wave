import 'package:flutter/material.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/presentation/screens/onBording/overview.dart';
import 'package:golden_wave/provider/language_provider.dart';
import 'package:golden_wave/provider/page_index_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/presentation/AuthManagement/sign_in.dart';
import 'package:golden_wave/presentation/screens/onBording/audio_production.dart';
import 'package:golden_wave/presentation/screens/onBording/creative_writing.dart';
import 'package:golden_wave/presentation/screens/onBording/media_qualification.dart';
import 'package:golden_wave/presentation/screens/onBording/music_workshop.dart';
import 'package:golden_wave/presentation/screens/onBording/video_production.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:iconsax/iconsax.dart';

class ExplainScreens extends StatelessWidget {
  const ExplainScreens({super.key});
  static final PageController _controller = PageController();

  Widget scrollingCircles() {
    return Container(
      alignment: const Alignment(0, .65),
      child: SmoothPageIndicator(
        controller: _controller,
        count: 6,
        effect: CustomizableEffect(
          activeDotDecoration: DotDecoration(
            width: 26,
            height: 16,
            color: MyColors.myYellow,
            borderRadius: BorderRadius.circular(4),
          ),
          dotDecoration: DotDecoration(
            width: 26,
            height: 10,
            color: MyColors.myWhite,
            borderRadius: BorderRadius.circular(4),
          ),
          spacing: 8.0,
        ),
      ),
    );
  }

  Widget elevatedButton() {
    return Consumer<PageIndexProvider>(
      builder: (context, pageIndexProvider, child) {
        int currentPageIndex = pageIndexProvider.currentPageIndex;
        return AnimatedPositioned(
          bottom: currentPageIndex == 5 ? 40.0 : 30.0,
          left: 0,
          right: 0,
          duration: const Duration(milliseconds: 300),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, SignIn.id);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  const Color(0xffD2B555),
                ),
              ),
              child: Text(
                currentPageIndex == 5
                    ? S.of(context).GetStarted
                    : S.of(context).Skip,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontFamily: 'inter',
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Scaffold(
          body: Stack(
            children: [
              PageView(
                scrollBehavior: const ScrollBehavior(),
                controller: _controller,
                onPageChanged: (index) {
                  context.read<PageIndexProvider>().setPageIndex(index);
                },
                children: const [
                  Overview(),
                  AudioProduction(),
                  VideoProduction(),
                  CreativeWriting(),
                  MusicWorkshop(),
                  MediaQualification()
                ],
              ),
              if (languageProvider.isLoading)
                Center(
                  child: LoadingAnimationWidget.hexagonDots(
                    color: Colors.red,
                    size: 50,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (languageProvider.language == 'en') {
                          languageProvider.setLanguageAr();
                        } else {
                          languageProvider.setLanguageEn();
                        }
                      },
                      icon: const Icon(
                        Iconsax.language_square,
                        color: MyColors.myYellow,
                        size: 35,
                      ),
                    ),
                    Text(
                      languageProvider.language,
                      style: const TextStyle(
                        fontSize: 30,
                        color: MyColors.myYellow,
                        fontFamily: 'abhayaLibre',
                        height: .3,
                      ),
                    ),
                  ],
                ),
              ),
              scrollingCircles(),
              elevatedButton(),
            ],
          ),
        );
      },
    );
  }
}
