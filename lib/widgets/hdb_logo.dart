import 'package:flutter/material.dart';
import 'package:verifyuser/utility/app_colors.dart';

/// HDB Financial Services Logo Widget
/// Displays the red square with "HDB" and blue "FINANCIAL SERVICES" text
class HDBLogo extends StatelessWidget {
  const HDBLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Red square with HDB
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.hdbRed,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Center(
            child: Text(
              'HDB',
              style: TextStyle(
                color: AppColors.whiteAppColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // FINANCIAL SERVICES text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FINANCIAL',
              style: TextStyle(
                color: AppColors.hdbBlue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              'SERVICES',
              style: TextStyle(
                color: AppColors.hdbBlue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

