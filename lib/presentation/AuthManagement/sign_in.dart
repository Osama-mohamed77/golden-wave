import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final ValueNotifier<bool> _obscurePasswordNotifier =
      ValueNotifier<bool>(true);

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
              icon: Icon(
                Iconsax.language_square,
                color: MyColors.myYellow,
                size: 30.r,
              ),
            ),
            Text(
              languageProvider.language,
              style: TextStyle(
                fontSize: 25.sp,
                color: MyColors.myYellow,
                fontFamily: 'abhayaLibre',
                height: -.01.h,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget logo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70.w,
          height: 85.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            image: const DecorationImage(
              image: AssetImage('assets/images/sign_in_logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Gap(5.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).LogoTitel,
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: 'AbhayaLibre',
                color: Colors.black,
              ),
            ),
            Text(
              S.of(context).LogoHint,
              style: TextStyle(
                fontSize: 17.sp,
                fontFamily: 'AbhayaLibre',
                color: MyColors.myGrey,
                height: .6.h,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget textForLogin() {
    return Text(
      S.of(context).loginHint,
      style: TextStyle(
        fontFamily: 'AbhayaLibre',
        color: MyColors.myGrey,
        fontSize: 15.sp,
      ),
    );
  }

  Widget emailTextFormField() {
    return TextFormField(
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
        contentPadding: EdgeInsets.symmetric(vertical: 20.r),
        hintStyle: TextStyle(fontFamily: 'AbhayaLibre', fontSize: 15.sp),
        labelStyle: TextStyle(fontFamily: 'AbhayaLibre', fontSize: 15.sp),
        prefixIcon: Icon(Icons.email, color: MyColors.myGrey, size: 25.r),
        hintText: S.of(context).hintEmail,
        labelText: S.of(context).labelEmail,
        filled: true,
        fillColor: Colors.white70,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: MyColors.myGrey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: MyColors.myGrey),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(color: MyColors.myYellow),
            gapPadding: 5.r),
      ),
    );
  }

  Widget passwordTextFormField() {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscurePasswordNotifier,
      builder: (context, obscurePassword, child) {
        return TextFormField(
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
          obscureText: obscurePassword,
          controller: _passwordController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20.r),
            hintStyle: TextStyle(fontFamily: 'AbhayaLibre', fontSize: 15.sp),
            labelStyle: TextStyle(fontFamily: 'AbhayaLibre', fontSize: 15.sp),
            prefixIcon: Icon(
              Iconsax.lock_15,
              color: MyColors.myGrey,
              size: 25.r,
            ),
            suffixIcon: IconButton(
              icon: Icon(obscurePassword ? Iconsax.eye_slash5 : Iconsax.eye4,
                  color: MyColors.myGrey, size: 25.r),
              onPressed: () {
                _obscurePasswordNotifier.value = !obscurePassword;
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: MyColors.myGrey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: MyColors.myGrey),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(color: MyColors.myYellow),
                gapPadding: 5.r),
            hintText: S.of(context).hintPassword,
            labelText: S.of(context).labelPassword,
          ),
        );
      },
    );
  }

  Widget forgotPassword() {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, ForgotPassword.id);
        },
        child: Text(
          S.of(context).forgotText,
          style: TextStyle(
              color: Colors.red, fontFamily: 'AbhayaLibre', fontSize: 15.sp),
        ),
      ),
    );
  }

  Widget signInButton(BuildContext context) {
    final authProvider = Provider.of<AuthProviderOS>(context);
    return SizedBox(
      height: 35.h,
      child: ElevatedButton(
        onPressed: () async {
          _formSubmitted = true;

          if (formKey.currentState != null &&
              formKey.currentState!.validate()) {
            try {
              await authProvider.signIn(
                  _emailController.text, _passwordController.text);

              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.emailVerified) {
                  Navigator.pushNamed(context, NavBar.id);
                } else {
                  showMessage(context,
                      title: S.of(context).verifyTitel,
                      desText: S.of(context).verifyDes,
                      icon: Iconsax.info_circle,
                      iconColor: Colors.blue,
                      backgroundColor: MyColors.myYellow,
                      textColor: Colors.black,
                      titelColor: Colors.black,
                      alignment: Alignment.topLeft);
                }
              } else {}
            } catch (e) {
              if (authProvider.errorMessage.isNotEmpty) {
                showMessage(context,
                    title: S.of(context).signInErrorTitel,
                    desText: S.of(context).signInErrorDes,
                    icon: Iconsax.close_circle,
                    iconColor: Colors.red,
                    backgroundColor: MyColors.myWhite,
                    textColor: Colors.red,
                    titelColor: Colors.red,
                    alignment: Alignment.topLeft);
              }
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.myYellow,
        ),
        child: Text(
          textAlign: TextAlign.center,
          S.of(context).signInButton,
          style: TextStyle(
            fontSize: 25.sp,
            color: Colors.black,
            fontFamily: 'AbhayaLibre',
          ),
        ),
      ),
    );
  }

  Widget signUpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).askForSignUp,
          style: TextStyle(
            fontFamily: 'AbhayaLibre',
            fontSize: 15.sp,
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
              fontSize: 16.sp,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderOS>(context);
    return Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
      return Scaffold(
        backgroundColor: MyColors.myWhite,
        body: Stack(children: [
          Form(
            key: formKey,
            child: ListView(
              children: [
                languageIcon(languageProvider),
                Gap(50.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: logo(),
                ),
                Gap(50.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: textForLogin(),
                ),
                Gap(10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: emailTextFormField(),
                ),
                Gap(10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: passwordTextFormField(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: forgotPassword(),
                ),
                Gap(20.h),
                if (authProvider.isLoading)
                  Center(
                    child: LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.black,
                      size: 30.r,
                    ),
                  )
                else
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: signInButton(context),
                  ),
                signUpButton(),
              ],
            ),
          ),
          if (languageProvider.isLoading)
            Center(
              child: LoadingAnimationWidget.hexagonDots(
                color: Colors.red,
                size: 50.r,
              ),
            ),
        ]),
      );
    });
  }
}
