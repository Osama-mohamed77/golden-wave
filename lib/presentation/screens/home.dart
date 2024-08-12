import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/presentation/widgets/section_tabs.dart';
import 'package:golden_wave/presentation/widgets/service_list.dart';
import 'package:golden_wave/provider/fetch_data_provider.dart';
import 'package:golden_wave/provider/home_provider.dart';
import 'package:golden_wave/provider/language_provider.dart';
import 'package:golden_wave/utils/user_const.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static String id = 'Home';

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final languageProvider = Provider.of<LanguageProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);

    // Reset selection on language change
    languageProvider.addListener(() {
      homeProvider.resetSelection();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget lineSections() {
    return Row(
      children: [
        Container(
          height: 1.5.h,
          width: 50.w,
          color: Colors.black,
        ),
        Text(
          S.of(context).Sections,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: MyColors.myYellow),
        ),
        Expanded(
          child: Container(
            height: 1.5.h,
            color: Colors.black,
          ),
        ),
        Icon(
          Icons.code,
          size: 23.r,
        ),
        Container(
          height: 1.5.h,
          width: 20.w,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget services() {
    return Container(
      constraints: BoxConstraints(minHeight: 500.h, maxHeight: 550.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xffD2D2D2),
            MyColors.myGrey,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: MyColors.myGrey),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          Gap(20.h),
          Consumer<HomeProvider>(
            builder: (context, provider, child) {
              return Center(
                child: Text(
                  provider.selectedSectionIndex == -1
                      ? S.of(context).titelForSelectSection
                      : '${S.of(context).ServicesWithin} ${provider.selectedSectionName}',
                  style: TextStyle(
                    fontFamily: 'inter',
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          Gap(10.h),
          Divider(
            thickness: 1.5.r,
            color: const Color(0xff818181),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
              child: Consumer<HomeProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: MyColors.myYellow,
                        size: 40.r,
                      ),
                    );
                  }
                  return provider.selectedSectionIndex == -1
                      ? Center(
                          child: Text(
                            S.of(context).hintForSelectSection,
                            style: TextStyle(
                              fontFamily: 'inter',
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ServiceList(provider.selectedSectionIndex);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(103.h),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffC9C9C9),
                    MyColors.myYellow,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            toolbarHeight: 1000.h,
            title: FadeTransition(
              opacity: _animation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<FetchDataProvider>(
                    builder: (context, value, child) => Text(
                      '${S.of(context).hi}, ${value.fullName.split(' ').first} 🎶',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'inter',
                      ),
                    ),
                  ),
                  Text(
                    S.of(context).appBarHint,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: MyColors.myGrey,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                color: Colors.black,
                iconSize: 30.r,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      backgroundColor: MyColors.myWhite,
      body: ListView(
        children: [
          Gap(20.h),
          lineSections(),
          Gap(20.h),
          const SectionTabs(),
          Gap(30.h),
          services(),
        ],
      ),
    );
  }
}
