import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/presentation/AuthManagement/sign_in.dart';
import 'package:golden_wave/presentation/widgets/nav_bar.dart';
import 'package:golden_wave/provider/auth_provider.dart';
import 'package:golden_wave/provider/booking_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

// Responsive utility functions
double getResponsiveFontSize(BuildContext context, double baseSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  double scale = (screenWidth + screenHeight) /
      2 /
      720; // Assuming 720 is a base screen size
  return baseSize * scale;
}

double getResponsiveHeight(BuildContext context, double baseHeight) {
  double screenHeight = MediaQuery.of(context).size.height;
  return baseHeight *
      (screenHeight / 720); // Assuming 720 is a base screen height
}

double getResponsiveWidth(BuildContext context, double baseWidth) {
  double screenWidth = MediaQuery.of(context).size.width;
  return baseWidth * (screenWidth / 360); // Assuming 360 is a base screen width
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  static String id = 'signUp';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String dropdownValue = 'Male';

  RegExp regexPassword =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  RegExp regexEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static RegExp nameRegExp = RegExp('[a-zA-Z]');
  static RegExp numberRegExp = RegExp('[0-9]');
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController fullName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confairmPassword = TextEditingController();

  Widget backIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          padding: EdgeInsets.only(right: getResponsiveWidth(context, 30)),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: getResponsiveFontSize(context, 35),
          ),
        ),
      ],
    );
  }

  Widget titelText() {
    return Text(
      'Create new\nAccount',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontFamily: 'AbhayaLibre',
        fontSize: getResponsiveFontSize(context, 40),
      ),
    );
  }

  Widget hintText() {
    return Text(
      'Please type full information below and we can create your account',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontFamily: 'AbhayaLibre',
        fontSize: getResponsiveFontSize(context, 20),
        color: MyColors.myGrey,
      ),
    );
  }

  Widget fullNameField() {
    return TextFormField(
      controller: fullName,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Your Name';
        }
        if (!nameRegExp.hasMatch(value) || numberRegExp.hasMatch(value)) {
          return 'Enter a Valid Name';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: MyColors.myWhite,
        labelText: 'Full name',
        labelStyle: TextStyle(
          fontFamily: 'AbhayaLibre',
          fontSize: getResponsiveFontSize(context, 17),
          color: MyColors.myGrey,
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      controller: email,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Your Email';
        } else if (!regexEmail.hasMatch(value)) {
          return 'Enter a valid Email';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: 'Email',
        labelStyle: TextStyle(
          fontFamily: 'AbhayaLibre',
          fontSize: getResponsiveFontSize(context, 17),
          color: MyColors.myGrey,
        ),
        filled: true,
        fillColor: MyColors.myWhite,
      ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: password,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter your Password';
        } else {
          if (!regexPassword.hasMatch(value)) {
            return 'Enter a valid password';
          }
          return null;
        }
      },
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: MyColors.myWhite,
        labelText: 'Password',
        labelStyle: TextStyle(
          fontFamily: 'AbhayaLibre',
          fontSize: getResponsiveFontSize(context, 17),
          color: MyColors.myGrey,
        ),
      ),
    );
  }

  Widget confirmField() {
    return TextFormField(
      controller: confairmPassword,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Your Confirm Password';
        } else if (value != password.text) {
          return 'Not match';
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: MyColors.myWhite,
        labelText: 'Confirm password',
        labelStyle: TextStyle(
          fontFamily: 'AbhayaLibre',
          fontSize: getResponsiveFontSize(context, 17),
          color: MyColors.myGrey,
        ),
      ),
    );
  }

  Widget signUpButton(
      AuthProviderOS authProvider, BookingProvider bookingProvider) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          try {
            if (formKey.currentState!.validate()) {
              await authProvider.signUp(
                  email.text, password.text, fullName.text);
              await bookingProvider.fetchFullName(); // Corrected method call
              Provider.of<AuthProviderOS>(context, listen: false)
                  .verifyAccount();
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.rightSlide,
                title: 'Verify account!',
                desc: 'Please verify your account to log in!',
                btnOkOnPress: () {},
              ).show();
            }
          } catch (e) {
            // Handle error
            print('Error: $e');
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            color: MyColors.myYellow,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          height: getResponsiveHeight(context, 40),
          width: double.infinity,
          child: Center(
            child: authProvider.isLoading
                ? const CircularProgressIndicator()
                : Text(
                    'Sign up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'AbhayaLibre',
                      fontSize: getResponsiveFontSize(context, 32),
                      color: Colors.black,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderOS>(context);
    final bookingProvider = Provider.of<BookingProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xffF0F0F0),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getResponsiveWidth(context, 20),
          ),
          child: ListView(
            children: [
              backIcon(),
              Gap(getResponsiveHeight(context, 40)),
              titelText(),
              Gap(getResponsiveHeight(context, 10)),
              hintText(),
              Gap(getResponsiveHeight(context, 30)),
              fullNameField(),
              Gap(getResponsiveHeight(context, 10)),
              emailField(),
              Gap(getResponsiveHeight(context, 10)),
              passwordField(),
              Gap(getResponsiveHeight(context, 10)),
              confirmField(),
              Gap(getResponsiveHeight(context, 40)),
              if (authProvider.isLoading)
                Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                    color: Colors.black,
                    size: 30,
                  ),
                )
              else
                signUpButton(authProvider, bookingProvider),
              Gap(getResponsiveHeight(context, 10)),
            ],
          ),
        ),
      ),
    );
  }
}
