import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/presentation/widgets/error_message.dart';
import 'package:golden_wave/provider/auth_provider.dart';
import 'package:golden_wave/provider/booking_provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  PhoneNumber? phoneNumber;

  Widget backIcon() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          size: 30.r,
        ),
      ),
    ]);
  }

  Widget titelText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            S.of(context).signUpTitel,
            style: TextStyle(
              fontFamily: 'AbhayaLibre',
              fontSize: 40.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget hintText() {
    return Text(
      S.of(context).signUpHint,
      style: TextStyle(
        fontFamily: 'AbhayaLibre',
        fontSize: 20.sp,
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
        contentPadding: EdgeInsets.symmetric(vertical: 20.r),
        labelStyle: TextStyle(
          fontFamily: 'AbhayaLibre',
          fontSize: 15.sp,
          color: MyColors.myGrey,
        ),
        prefixIcon: Icon(
          Icons.person,
          color: MyColors.myGrey,
          size: 25.r,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        filled: true,
        fillColor: MyColors.myWhite,
        labelText: S.of(context).labelName,
      ),
    );
  }

  Widget phoneNumberForm() {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        phoneNumber = number;
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
        contentPadding: EdgeInsets.symmetric(vertical: 20.r),
        labelStyle: TextStyle(
          fontFamily: 'AbhayaLibre',
          fontSize: 15.sp,
          color: MyColors.myGrey,
        ),
        prefixIcon: Icon(
          Icons.phone,
          color: MyColors.myGrey,
          size: 25.r,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        filled: true,
        fillColor: MyColors.myWhite,
        labelText: S.of(context).labelPhone,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).emptyPhone;
        }
        return null;
      },
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
        contentPadding: EdgeInsets.symmetric(vertical: 20.r),
        labelStyle: TextStyle(
          fontFamily: 'AbhayaLibre',
          fontSize: 15.sp,
          color: MyColors.myGrey,
        ),
        prefixIcon: Icon(
          Icons.email,
          color: MyColors.myGrey,
          size: 25.r,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        labelText: S.of(context).labelEmail,
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
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20.r),
        labelStyle: TextStyle(
          fontFamily: 'AbhayaLibre',
          fontSize: 15.sp,
          color: MyColors.myGrey,
        ),
        prefixIcon: Icon(
          Iconsax.lock_15,
          color: MyColors.myGrey,
          size: 25.r,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        filled: true,
        fillColor: MyColors.myWhite,
        labelText: S.of(context).labelPassword,
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
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20.r),
        labelStyle: TextStyle(
          fontFamily: 'AbhayaLibre',
          fontSize: 15.sp,
          color: MyColors.myGrey,
        ),
        prefixIcon: Icon(
          Iconsax.lock_15,
          color: MyColors.myGrey,
          size: 25.r,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        filled: true,
        fillColor: MyColors.myWhite,
        labelText: S.of(context).labelConfirm,
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
              await authProvider.signUp(email.text, phoneController.text,
                  password.text, fullName.text, context);
              Provider.of<AuthProviderOS>(context, listen: false)
                  .verifyAccount();
              showMessage(context,
                  title: S.of(context).verifyTitel,
                  desText: S.of(context).verifyDes,
                  icon: Iconsax.info_circle,
                  iconColor: Colors.blue,
                  backgroundColor: MyColors.myYellow,
                  textColor: Colors.black,
                  titelColor: Colors.black,
                  alignment: Alignment.topCenter);
              Navigator.pop(context);
            }
          } catch (e) {
            showMessage(context,
                title: S.of(context).Error,
                desText: S.of(context).ErrorDes,
                icon: Iconsax.danger,
                iconColor: Colors.red,
                backgroundColor: MyColors.myYellow,
                textColor: Colors.black,
                titelColor: Colors.black,
                alignment: Alignment.topCenter);
          }
        },
        child: Container(
          height: 35.h,
          decoration: BoxDecoration(
            color: MyColors.myYellow,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Center(
            child: authProvider.isLoading
                ? LoadingAnimationWidget.threeArchedCircle(
                    color: Colors.black,
                    size: 30.r,
                  )
                : Text(
                    S.of(context).signUpText,
                    style: TextStyle(
                      fontFamily: 'AbhayaLibre',
                      fontSize: 25.sp,
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
      backgroundColor: MyColors.myWhite,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(30.h),
              backIcon(),
              titelText(),
              Gap(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: hintText(),
              ),
              Gap(20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: fullNameField(),
              ),
              Gap(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: phoneNumberForm(),
              ),
              Gap(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: emailField(),
              ),
              Gap(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: passwordField(),
              ),
              Gap(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: confirmField(),
              ),
              Gap(40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: signUpButton(authProvider, bookingProvider),
              ),
              Gap(30.h),
            ],
          ),
        ),
      ),
    );
  }
}
