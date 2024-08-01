import 'package:flutter/material.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/presentation/AuthManagement/sign_in.dart';
import 'package:golden_wave/provider/auth_provider.dart';
import 'package:golden_wave/provider/language_provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(decoration: BoxDecoration(border: Border.all()),height: 80,width: 80,
              child: IconButton(
                  onPressed: () {
                    Provider.of<AuthProviderOS>(context, listen: false).signOut();
                    Navigator.pushNamed(context, SignIn.id);
                  },
                  icon: const Icon(
                    Icons.logout,
                    size: 50,
                    color: MyColors.myGrey,
                  )),
            ),
            Column(
              children: [
                Consumer<LanguageProvider>(
                  builder: (context, languageProvider, child) {
                    return Column(
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
                            size: 55,
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
                    );
                    
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
