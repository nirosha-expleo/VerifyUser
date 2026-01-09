import 'package:flutter/material.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';
import 'package:verifyuser/widgets/hdb_logo.dart';

/// Offer Rejected Screen
/// Shows thank you message after rejecting the loan offer
class OfferRejectedScreen extends StatelessWidget {
  const OfferRejectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteAppColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteAppColor,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMobileMaxWidth(context),
          ),
          child: Container(
            margin: ResponsiveHelper.getScreenPadding(context),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppLogo(),
                const SizedBox(height: 48),
                // Thank you icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.appButtonColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.thumb_up,
                    size: 60,
                    color: AppColors.appButtonColor,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Thanks for your time',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.appTitleBlack,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'We will connect with you later with next offer',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textfieldColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                // Decorative element
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.adColorlight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 48,
                        color: AppColors.appButtonColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'We will notify you about new offers via email',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.appTitleBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

