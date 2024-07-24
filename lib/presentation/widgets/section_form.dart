import 'package:flutter/material.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/provider/home_provider.dart';
import 'package:provider/provider.dart';

class SectionForm extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SectionForm({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final provider = Provider.of<HomeProvider>(context, listen: false);
        provider.updateSelectedSection(0, title);
        provider.fetchServices(); // Fetch services when a section is selected
        onTap();
      },
      child: Container(
        height: 43,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? MyColors.myYellow : MyColors.myGrey,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? MyColors.myYellow : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
