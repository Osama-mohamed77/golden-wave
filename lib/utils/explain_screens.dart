import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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
    return SmoothPageIndicator(
      controller: _controller,
      count: 6,
      effect: CustomizableEffect(
        activeDotDecoration: DotDecoration(
          width: 12.0.sp,
          height: 10.0.sp,
          color: MyColors.myYellow,
          borderRadius: BorderRadius.circular(4.0.sp),
        ),
        dotDecoration: DotDecoration(
          width: 25.0.sp,
          height: 7.0.sp,
          color: MyColors.myWhite,
          borderRadius: BorderRadius.circular(4.0.sp),
        ),
        spacing: 8.0.sp,
      ),
    );
  }

  Widget elevatedButton() {
    return Consumer<PageIndexProvider>(
      builder: (context, pageIndexProvider, child) {
        int currentPageIndex = pageIndexProvider.currentPageIndex;
        return SizedBox(
          height: 30.h,
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
              style: TextStyle(
                fontSize: 15.0.sp,
                color: Colors.black,
                fontFamily: 'inter',
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
                    size: 50.0.sp,
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(
                    top: 25.0.sp, left: 10.0.sp, right: 10.0.sp),
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
                      icon: Icon(
                        Iconsax.language_square,
                        color: MyColors.myYellow,
                        size: 30.0.sp,
                      ),
                    ),
                    Text(
                      languageProvider.language,
                      style: TextStyle(
                        fontSize: 20.0.sp,
                        color: MyColors.myYellow,
                        fontFamily: 'abhayaLibre',
                        height: .2,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      scrollingCircles(),
                      const Spacer(),
                      elevatedButton(),
                      const Spacer(),

                    ],
                  ),
                  Gap(30.h)
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
