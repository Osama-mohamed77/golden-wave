import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/presentation/widgets/section_tabs.dart';
import 'package:golden_wave/presentation/widgets/service_list.dart';
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
          height: 1.5,
          width: 50,
          color: Colors.black,
        ),
        Text(
          S.of(context).Sections,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: MyColors.myYellow),
        ),
        Expanded(
          child: Container(
            height: 1.5,
            width: 0,
            color: Colors.black,
          ),
        ),
        const Icon(Icons.code),
        Container(
          height: 1.5,
          width: 20,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget services() {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.3,
        maxHeight: MediaQuery.of(context).size.height * 0.63,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffEEEEEE),
        border: Border.all(color: MyColors.myGrey),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const Gap(20),
          Consumer<HomeProvider>(
            builder: (context, provider, child) {
              return Center(
                child: Text(
                  provider.selectedSectionIndex == -1
                      ? S.of(context).titelForSelectSection
                      : '${S.of(context).ServicesWithin} ${provider.selectedSectionName}',
                  style: const TextStyle(
                    fontFamily: 'inter',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          const Gap(10),
          const Divider(
            thickness: 1.5,
            color: Color(0xff818181),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Consumer<HomeProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Center(
                      child: LoadingAnimationWidget.threeArchedCircle(
                        color: Colors.black,
                        size: 30,
                      ),
                    );
                  }
                  return provider.selectedSectionIndex == -1
                      ? Center(
                          child: Text(
                            S.of(context).hintForSelectSection,
                            style: const TextStyle(
                              fontFamily: 'inter',
                              fontSize: 17,
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
        preferredSize: const Size.fromHeight(103),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.myYellow,
            toolbarHeight: 103,
            title: FadeTransition(
              opacity: _animation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${S.of(context).hi}, ${UserConst.fullName.split(' ').first} 🎶',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'inter',
                    ),
                  ),
                  Text(
                    S.of(context).appBarHint,
                    style: const TextStyle(
                        fontSize: 14,
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
                iconSize: 30,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const Gap(20),
          lineSections(),
          const Gap(10),
          const SectionTabs(),
          const Gap(20),
          services(),
        ],
      ),
    );
  }
}
