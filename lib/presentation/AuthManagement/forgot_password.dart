import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/presentation/widgets/error_message.dart';
import 'package:golden_wave/provider/auth_provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  static RegExp regexEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static String id = 'ForgotPassword';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> passwordReset() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading = true;

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: emailController.text.trim())
          .get();

      if (querySnapshot.docs.isEmpty) {
        // Email does not exist in Firestore
        throw Exception(S.of(context).notFound);
      }

      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      showMessage(context,
          title: S.of(context).Success,
          desText: S.of(context).sendLink,
          icon: Icons.done_all_sharp,
          iconColor: Colors.black,
          backgroundColor: MyColors.myYellow,
          textColor: Colors.black,
          titelColor: Colors.black,
          alignment: Alignment.topLeft);

      Navigator.pop(context);
    } catch (e) {
      String errorMessage;
      if (e.toString().contains('Email not found')) {
        errorMessage = S.of(context).emailNotFoundDes;
      } else {
        errorMessage = S.of(context).failedSendLink;
      }
      showMessage(context,
          title: S.of(context).Error,
          desText: errorMessage,
          icon: Iconsax.close_circle,
          iconColor: Colors.black,
          backgroundColor: MyColors.myYellow,
          textColor: Colors.black,
          titelColor: Colors.black,
          alignment: Alignment.topLeft);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget backIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 30.r,
          ),
        ),
      ],
    );
  }

  Widget titleText() {
    return Text(
      S.of(context).forgotScreenTitel,
      style: TextStyle(
        fontFamily: 'AbhayaLibre',
        fontSize: 40.sp,
      ),
    );
  }

  Widget hintText() {
    return Text(
      S.of(context).fogotScreenDes,
      style: TextStyle(
        fontFamily: 'AbhayaLibre',
        fontSize: 20.sp,
        color: MyColors.myGrey,
      ),
    );
  }

  Widget emailTextFormField(RegExp forgotpassword) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return S.of(context).emptyEmail;
        } else if (!forgotpassword.hasMatch(value)) {
          return S.of(context).validEmail;
        }
        return null;
      },
      controller: emailController,
      decoration: InputDecoration(
        hintText: S.of(context).hintEmail,
        contentPadding: EdgeInsets.symmetric(vertical: 20.r),
        hintStyle: TextStyle(fontFamily: 'AbhayaLibre', fontSize: 15.sp),
        labelStyle: TextStyle(fontFamily: 'AbhayaLibre', fontSize: 15.sp),
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
        prefixIcon: Icon(
          Icons.email,
          color: MyColors.myGrey,
          size: 25.r,
        ),
      ),
    );
  }

  Widget sendButton() {
    return GestureDetector(
      onTap: () async {
        await passwordReset();
      },
      child: Container(
        height: 35.h,
        decoration: BoxDecoration(
          color: MyColors.myYellow,
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        child: Center(
          child: Text(
            S.of(context).sendText,
            style: TextStyle(
              fontFamily: 'AbhayaLibre',
              fontWeight: FontWeight.bold,
              fontSize: 25.sp,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var forgotpassword = ForgotPassword.regexEmail;
    final authProvider = Provider.of<AuthProviderOS>(context);

    return Scaffold(
      backgroundColor: MyColors.myWhite,
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            backIcon(),
            Gap(60.w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              child: titleText(),
            ),
            Gap(30.w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              child: hintText(),
            ),
            Gap(60.w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              child: emailTextFormField(forgotpassword),
            ),
            if (authProvider.isLoading)
              Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: Colors.black,
                  size: 30.r,
                ),
              ),
            Gap(60.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              child: sendButton(),
            ),
            Gap(40.h),
          ],
        ),
      ),
    );
  }
}
