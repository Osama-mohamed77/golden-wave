import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/presentation/AuthManagement/sign_in.dart';
import 'package:golden_wave/presentation/screens/account_details.dart';
import 'package:golden_wave/presentation/screens/help.dart';
import 'package:golden_wave/presentation/widgets/forward_button.dart';
import 'package:golden_wave/presentation/widgets/setting_item.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:golden_wave/provider/auth_provider.dart';
import 'package:golden_wave/provider/fetch_data_provider.dart';
import 'package:golden_wave/provider/language_provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  static String id = 'Settings';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Provider.of<FetchDataProvider>(context, listen: false).fetchData();

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  void _showLanguageSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Consumer<LanguageProvider>(
          builder: (context, languageProvider, child) {
            return Card(
              margin: EdgeInsets.all(20.0.r),
              child: Padding(
                padding: EdgeInsets.all(20.0.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text('English'),
                      onTap: () async {
                        await languageProvider.setLanguageEn();
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text('العربية'),
                      onTap: () async {
                        await languageProvider.setLanguageAr();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myWhite,
      body: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          if (languageProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 500),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(30.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(50.h),
                    Text(
                      S.of(context).settings,
                      style: TextStyle(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(40.h),
                    Text(
                      S.of(context).account,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gap(20.h),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40.r,
                            child: ClipOval(
                              child: Image.asset(
                                "assets/images/profile.png",
                                width: 80.r,
                                height: 80.r,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Gap(20.h),
                          Consumer<FetchDataProvider>(
                            builder: (context, value, child) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value.fullName,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Gap(10.h),
                                Text(
                                  S.of(context).accountDetails,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: MyColors.myGrey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          ForwardButton(
                            onTap: () {
                              Navigator.pushNamed(context, AccountDetails.id);
                            },
                          )
                        ],
                      ),
                    ),
                    Gap(40.h),
                    Text(
                      S.of(context).settings,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gap(20.h),
                    SettingItem(
                      title: S.of(context).language,
                      icon: Iconsax.global,
                      bgColor: Colors.orange.shade100,
                      iconColor: Colors.orange,
                      value: languageProvider.language == 'en'
                          ? 'English'
                          : 'العربية',
                      onTap: () => _showLanguageSelection(context),
                    ),
                    Gap(20.h),
                    SettingItem(
                      title: S.of(context).help,
                      icon: Iconsax.danger,
                      bgColor: Colors.green.shade100,
                      iconColor: Colors.green,
                      onTap: () {
                        Navigator.pushNamed(context, Help.id);
                      },
                    ),
                    Gap(20.h),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red.shade100,
                            ),
                            child: const Icon(
                              Iconsax.logout,
                              color: Colors.red,
                            ),
                          ),
                          Gap(10.w),
                          Text(
                            S.of(context).logout,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.question,
                                bodyHeaderDistance:
                                    BorderSide.strokeAlignCenter,
                                animType: AnimType.rightSlide,
                                title: S.of(context).askToLogOut,
                                titleTextStyle: const TextStyle(
                                  fontFamily: 'inter',
                                ),
                                btnOkOnPress: () {
                                  Provider.of<AuthProviderOS>(context,
                                          listen: false)
                                      .signOut();
                                  Navigator.pushNamed(context, SignIn.id);
                                },
                                btnCancelText: S.of(context).cancel,
                                btnOkText: S.of(context).ok,
                                btnCancelOnPress: () {},
                                width: 350.r,
                                transitionAnimationDuration:
                                    const Duration(milliseconds: 200),
                              ).show();
                            },
                            child: Container(
                              width: 50.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: const Icon(Iconsax.logout),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
