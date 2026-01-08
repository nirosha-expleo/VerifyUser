import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';
import 'package:verifyuser/utility/navigation_helper.dart';

/// Screen 7: Email Verification Link Sent
/// Features: Envelope icon, confirmation message
class EmailVerificationSentScreen extends StatelessWidget {
  const EmailVerificationSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = 'xxxxx@xxxxx.com'; // Dummy data
    
    return Scaffold(
      backgroundColor: AppColors.whiteAppColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteAppColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.appTitleBlack),
          onPressed: () => NavigationHelper.smartPop(context),
        ),
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
                Icon(
                  Icons.mail,
                  size: 120,
                  color: AppColors.appButtonColor,
                ),
                const SizedBox(height: 32),
                Text(
                  'Email verification link has been sent to',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textfieldColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  email,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.appButtonColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Please verify the same to get your loan approved.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textfieldColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Text(
                  "TnC's applicable.",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.appLabelColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
