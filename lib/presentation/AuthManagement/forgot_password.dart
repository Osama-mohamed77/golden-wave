import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/presentation/AuthManagement/sign_in.dart';
import 'package:golden_wave/provider/auth_provider.dart';
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
    setState(() {
      isLoading = true;
    });

    try {
      // Check if the email exists in Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: emailController.text.trim())
          .get();

      if (querySnapshot.docs.isEmpty) {
        // Email does not exist in Firestore
        throw Exception(S.of(context).notFound);
      }

      // Send password reset email
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: S.of(context).Success,
        desc: S.of(context).sendLink,
        btnOkOnPress: () {
          Navigator.pushNamed(context, SignIn.id);
        },
      ).show();
    } catch (e) {
      String errorMessage;
      if (e.toString().contains('Email not found')) {
        errorMessage = S.of(context).emailNotFoundDes;
      } else {
        errorMessage = S.of(context).failedSendLink;
      }
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: S.of(context).Error,
        desc: errorMessage,
        btnOkOnPress: () {},
      ).show();
      return;
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
          padding: const EdgeInsets.only(right: 30),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
      ],
    );
  }

  Widget titleText() {
    return Text(
      S.of(context).forgotScreenTitel,
      style: const TextStyle(
        fontFamily: 'AbhayaLibre',
        fontSize: 40,
      ),
    );
  }

  Widget hintText() {
    return Text(
      S.of(context).fogotScreenDes,
      style: const TextStyle(
        fontFamily: 'AbhayaLibre',
        fontSize: 20,
        color: MyColors.myGrey,
      ),
    );
  }

  Widget emailTextFormField(RegExp forgotpassword) {
    return SizedBox(
      child: TextFormField(
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

  Widget sendButton() {
    return GestureDetector(
      onTap: () async {
        await passwordReset();
      },
      child: Container(
        decoration: const BoxDecoration(
          color: MyColors.myYellow,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        height: 50,
        width: 234,
        child: Center(
          child: Text(
            S.of(context).sendText,
            style: const TextStyle(
              fontFamily: 'AbhayaLibre',
              fontWeight: FontWeight.bold,
              fontSize: 32,
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
      backgroundColor: const Color(0xffF0F0F0),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          children: [
            backIcon(),
            const Gap(60),
            titleText(),
            const Gap(30),
            hintText(),
            const Gap(60),
            emailTextFormField(forgotpassword),
            if (authProvider.isLoading)
              Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: Colors.black,
                  size: 30,
                ),
              ),
            const Gap(60),
            sendButton()
          ],
        ),
      ),
    );
  }
}
