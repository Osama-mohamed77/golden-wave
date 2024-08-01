import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/presentation/AuthManagement/forgot_password.dart';
import 'package:golden_wave/presentation/AuthManagement/sign_up.dart';
import 'package:golden_wave/presentation/widgets/error_message.dart';
import 'package:golden_wave/presentation/widgets/nav_bar.dart';
import 'package:golden_wave/provider/auth_provider.dart';
import 'package:golden_wave/provider/language_provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  static String id = 'SignIn';

  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var name = 'Sign in';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  RegExp regexEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  GlobalKey<FormState> formKey = GlobalKey();
  bool _formSubmitted = false;

  Widget languageIcon(languageProvider) {
    return Row(
      children: [
        Column(
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
      ],
    );
  }

  Widget logo(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: screenWidth * 0.2,
          height: screenWidth * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage('assets/images/logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Gap(5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).LogoTitel,
              style: TextStyle(
                fontSize: screenWidth * 0.075,
                fontFamily: 'AbhayaLibre',
                color: Colors.black,
              ),
            ),
            Text(
              S.of(context).LogoHint,
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontFamily: 'AbhayaLibre',
                color: MyColors.myGrey,
                height: .6,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget textForLogin(double screenWidth) {
    return Text(
      S.of(context).loginHint,
      style: TextStyle(
        fontFamily: 'AbhayaLibre',
        color: MyColors.myGrey,
        fontSize: screenWidth * 0.04,
      ),
    );
  }

  Widget emailTextFormField(double screenWidth) {
    return SizedBox(
      child: TextFormField(
        validator: (value) {
          if (_formSubmitted) {
            if (value!.isEmpty) {
              return S.of(context).emptyEmail;
            } else if (!regexEmail.hasMatch(value)) {
              return S.of(context).validEmail;
            }
          }
          return null;
        },
        controller: _emailController,
        decoration: InputDecoration(
          hintText: S.of(context).hintEmail,
          labelText: S.of(context).labelEmail,
          filled: true,
          fillColor: Colors.white70,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: MyColors.myGrey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: MyColors.myGrey),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: MyColors.myYellow),
              gapPadding: 5),
        ),
      ),
    );
  }

  Widget passwordTextFormField(double screenWidth) {
    return SizedBox(
      child: TextFormField(
        validator: (value) {
          if (_formSubmitted) {
            if (value!.isEmpty) {
              return S.of(context).emptyPassword;
            } else {
              if (!regex.hasMatch(value)) {
                return S.of(context).validPassword;
              }
            }
          }
          return null;
        },
        obscureText: true,
        controller: _passwordController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: MyColors.myGrey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: MyColors.myGrey),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: MyColors.myYellow),
              gapPadding: 5),
          hintText: S.of(context).hintPassword,
          labelText: S.of(context).labelPassword,
        ),
      ),
    );
  }

  Widget forgotPassword(double screenWidth) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, ForgotPassword.id);
        },
        child: Text(
          S.of(context).forgotText,
          style: TextStyle(
            color: Colors.red,
            fontFamily: 'AbhayaLibre',
            fontSize: screenWidth * 0.04,
          ),
        ),
      ),
    );
  }

  Widget signInButton(double screenWidth, BuildContext context) {
    final authProvider = Provider.of<AuthProviderOS>(context);
    return ElevatedButton(
      onPressed: () async {
        _formSubmitted = true;

        if (formKey.currentState != null && formKey.currentState!.validate()) {
          try {
            // Attempt to sign in
            await authProvider.signIn(
                _emailController.text, _passwordController.text);

            // Check if the email is verified
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                Navigator.pushNamed(context, NavBar.id);
              } else {
                showMessage(context,
                    title: S.of(context).verifyTitel,
                    desText: S.of(context).verifyDes,
                    icon: Iconsax.info_circle,
                    iconColor: Colors.blue,backgroundColor: MyColors.myYellow ,textColor: Colors.black,alignment: Alignment.topLeft);
              }
            } else {
              print('User is null after sign-in.');
            }
          } catch (e) {
            if (authProvider.errorMessage.isNotEmpty) {
              showMessage(context,
                  title: S.of(context).signInErrorTitel,
                  desText: S.of(context).signInErrorDes,
                  icon: Iconsax.close_circle,
                  iconColor: Colors.red,backgroundColor: Colors.red,textColor: Colors.white,alignment: Alignment.topLeft);
            }
            print('Sign-in error: $e');
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.myYellow, // Golden color
      ),
      child: Text(
        textAlign: TextAlign.center,
        S.of(context).signInButton,
        style: TextStyle(
          fontSize: screenWidth * 0.06,
          color: Colors.black,
          fontFamily: 'AbhayaLibre',
        ),
      ),
    );
  }

  Widget signUpButton(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).askForSignUp,
          style: TextStyle(
            fontFamily: 'AbhayaLibre',
            fontSize: screenWidth * 0.04,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, SignUp.id);
          },
          child: Text(
            S.of(context).signUpText,
            style: TextStyle(
              fontFamily: 'AbhayaLibre',
              fontSize: screenWidth * 0.04,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthProviderOS>(context);
    return Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
      return Scaffold(
        backgroundColor: MyColors.myWhite,
        body: Stack(children: [
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  languageIcon(languageProvider),
                  Gap(screenWidth * 0.1),
                  logo(screenWidth),
                  Gap(screenWidth * 0.2),
                  textForLogin(screenWidth),
                  Gap(screenWidth * 0.04),
                  emailTextFormField(screenWidth),
                  Gap(screenWidth * 0.04),
                  passwordTextFormField(screenWidth),
                  Gap(screenWidth * 0.04),
                  forgotPassword(screenWidth),
                  Gap(screenWidth * 0.05),
                  if (authProvider.isLoading)
                    Center(
                      child: LoadingAnimationWidget.threeArchedCircle(
                        color: Colors.black,
                        size: 30,
                      ),
                    )
                  else
                    signInButton(screenWidth, context),
                  Gap(screenWidth * 0.05),
                  signUpButton(screenWidth),
                ],
              ),
            ),
          ),
          if (languageProvider.isLoading)
            Center(
              child: LoadingAnimationWidget.hexagonDots(
                color: Colors.red,
                size: 50,
              ),
            ),
        ]),
      );
    });
  }
}
