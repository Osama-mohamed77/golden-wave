import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/presentation/AuthManagement/forgot_password.dart';
import 'package:golden_wave/presentation/AuthManagement/sign_up.dart';
import 'package:golden_wave/presentation/widgets/nav_bar.dart';
import 'package:golden_wave/provider/auth_provider.dart';
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
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  GlobalKey<FormState> formKey = GlobalKey();
  bool _formSubmitted = false;

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
              'Golden wave',
              style: TextStyle(
                fontSize: screenWidth * 0.075,
                fontFamily: 'AbhayaLibre',
                color: Colors.black,
              ),
            ),
            Text(
              'Media Innovators',
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
      'Please login to use the app',
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
              return 'Enter Your Email';
            } else if (!regexEmail.hasMatch(value)) {
              return 'Enter a valid email';
            }
          }
          return null;
        },
        controller: _emailController,
        decoration: InputDecoration(
          hintText: 'Enter Your Email',
          labelText: 'Email',
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
              return 'please enter your Password';
            } else {
              if (!regex.hasMatch(value)) {
                return 'Enter valid password';
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
          hintText: 'Enter Your password',
          labelText: 'Password',
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
          'Forgot password?',
          style: TextStyle(
            color: Colors.black,
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

        if (formKey.currentState!.validate()) {
          try {
            // Attempt to sign in
            await authProvider.signIn(
                _emailController.text, _passwordController.text);

            // Check if the email is verified
            if (FirebaseAuth.instance.currentUser != null &&
                FirebaseAuth.instance.currentUser!.emailVerified) {
              Navigator.pushNamed(context, NavBar.id);
            } else {
              // Show a dialog if email is not verified
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.rightSlide,
                title: 'Verify account!',
                desc: 'Please verify your account to log in!',
                btnOkOnPress: () {},
              ).show();
            }
          } catch (e) {
            // Handle sign-in errors
            if (authProvider.errorMessage.isNotEmpty) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.rightSlide,
                title: 'Sign-in Error',
                desc: 'Wrong email or password',
                btnOkOnPress: () {},
              ).show();
            }
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.myYellow, // Golden color
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.3,
          vertical: screenWidth * 0.02,
        ),
      ),
      child: Text(
        'Sign in',
        style: TextStyle(
          fontSize: screenWidth * 0.07,
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
          "Don't have an account?",
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
            'Sign up',
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
    return Scaffold(
      backgroundColor: MyColors.myWhite,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Gap(screenWidth * 0.2),
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
    );
  }
}
