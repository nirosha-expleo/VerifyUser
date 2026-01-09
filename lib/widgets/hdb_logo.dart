import 'package:flutter/material.dart';
import 'package:verifyuser/utility/app_colors.dart';

/// App Logo Widget
/// Displays the app logo
class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo square
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.appButtonColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Center(
            child: Text(
              '[  ]',//[ ]
              style: TextStyle(
                color: AppColors.whiteAppColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // EXPLEO text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'EXPLEO',
              style: TextStyle(
                color: AppColors.appButtonColor,
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

