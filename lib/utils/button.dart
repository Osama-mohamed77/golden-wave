import 'package:flutter/material.dart';
import 'package:golden_wave/constants/my_colors.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.width,
    required this.title,
    required this.onPressed, required int height, required String text,
  });

  final double width;
  final String title;

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.myYellow,
          foregroundColor: Colors.black,
          
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'inter'),
        ),
      ),
    );
  }
}
