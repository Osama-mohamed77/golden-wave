import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showMessage(BuildContext context,
    {required String title,
    required String desText,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required Color textColor,
    required Alignment alignment,
    required Color titelColor}) {
  toastification.show(
    context: context,
    type: ToastificationType.error,
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 5),
    title: Text(title),
    description: RichText(
      text: TextSpan(
        text: desText,
        style: TextStyle(color: textColor),
      ),
    ),
    alignment: alignment,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    icon: Icon(icon),
    showIcon: true,
    primaryColor: iconColor,
    backgroundColor: backgroundColor,
    foregroundColor: titelColor,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    showProgressBar: false,
    closeButtonShowType: CloseButtonShowType.always,
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
    applyBlurEffect: true,
  );
}
