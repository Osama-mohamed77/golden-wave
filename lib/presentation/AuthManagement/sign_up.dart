import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/provider/auth_provider.dart';
import 'package:golden_wave/provider/booking_provider.dart';
import 'package:golden_wave/provider/language_provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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
  RegExp regexPassword =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  RegExp regexEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static RegExp nameRegExp = RegExp('[a-zA-Z]');
  static RegExp numberRegExp = RegExp('[0-9]');
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confairmPassword = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  PhoneNumber? _phoneNumber;
  Widget backIcon() {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      IconButton(
        padding: EdgeInsets.only(
          right: languageProvider.language == 'en' ? 30.0 : 0.0,
          left: languageProvider.language == 'ar' ? 30.0 : 0.0,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          size: getResponsiveFontSize(context, 35),
        ),
      ),
    ]);
  }

  Widget titelText() {
    return Text(
      S.of(context).signUpTitel,
      style: TextStyle(
        fontFamily: 'AbhayaLibre',
        fontSize: getResponsiveFontSize(context, 40),
      ),
    );
  }

  Widget hintText() {
    return Text(
      S.of(context).signUpHint,
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
          return S.of(context).emptyName;
        }
        if (!nameRegExp.hasMatch(value) || numberRegExp.hasMatch(value)) {
          return S.of(context).validName;
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: MyColors.myWhite,
        labelText: S.of(context).labelName,
        labelStyle: TextStyle(
          fontFamily: 'AbhayaLibre',
          fontSize: getResponsiveFontSize(context, 17),
          color: MyColors.myGrey,
        ),
      ),
    );
  }

  Widget phoneNumber() {
    final PhoneNumber initialPhoneNumber = PhoneNumber(
      isoCode: 'SA',
      dialCode: '+966',
    );

    return SizedBox(
      height: 65,
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {
          _phoneNumber =
              number; 
        },
        onInputValidated: (bool value) {
          // Handle input validation if needed
        },
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          showFlags: true,
        ),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        textFieldController: phoneController,
        formatInput: false,
        keyboardType:
            const TextInputType.numberWithOptions(signed: true, decimal: true),
        inputDecoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white70,
          labelText: S.of(context).labelPhone,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return S.of(context).emptyPhone;
          }
          return null;
        },
        initialValue: initialPhoneNumber, 
        countrySelectorScrollControlled: true,
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      controller: email,
      validator: (value) {
        if (value!.isEmpty) {
          return S.of(context).emptyEmail;
        } else if (!regexEmail.hasMatch(value)) {
          return S.of(context).validEmail;
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: S.of(context).labelEmail,
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
          return S.of(context).emptyPassword;
        } else {
          if (!regexPassword.hasMatch(value)) {
            return S.of(context).validPassword;
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
        labelText: S.of(context).labelPassword,
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
          return S.of(context).emptyConfirm;
        } else if (value != password.text) {
          return S.of(context).notMatchConfirm;
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
        labelText: S.of(context).labelConfirm,
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
              await authProvider.signUp(email.text, phoneController.text as int,
                  password.text, fullName.text);
              await bookingProvider.fetchFullName();
              Provider.of<AuthProviderOS>(context, listen: false)
                  .verifyAccount();
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.rightSlide,
                title: S.of(context).verifyTitel,
                desc: S.of(context).verifyDes,
                btnOkOnPress: () {},
              ).show();
            }
          } catch (e) {
            return;
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
                    S.of(context).signUpText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'AbhayaLibre',
                      fontSize: getResponsiveFontSize(context, 30),
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
            padding: EdgeInsets.zero,
            children: [
              Gap(getResponsiveHeight(context, 30)),
              backIcon(),
              Gap(getResponsiveHeight(context, 40)),
              titelText(),
              Gap(getResponsiveHeight(context, 10)),
              hintText(),
              Gap(getResponsiveHeight(context, 30)),
              fullNameField(),
              Gap(getResponsiveHeight(context, 10)),
              phoneNumber(),
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
              SizedBox(height: getResponsiveHeight(context, 10)),
            ],
          ),
        ),
      ),
    );
  }
}
