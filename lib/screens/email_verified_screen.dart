import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';
import 'package:verifyuser/utility/navigation_helper.dart';
import 'package:intl/intl.dart';

/// Screen 8: Email Verified Successfully
/// Features: Date, breadcrumbs, success message with green checkmark, auto-redirect to loader
class EmailVerifiedScreen extends StatefulWidget {
  const EmailVerifiedScreen({super.key});

  @override
  State<EmailVerifiedScreen> createState() => _EmailVerifiedScreenState();
}

class _EmailVerifiedScreenState extends State<EmailVerifiedScreen> {
  @override
  void initState() {
    super.initState();
    // Auto-redirect to processing loader after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/processing-loader');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('EEE, d MMM yyyy').format(now);
    
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date on the left
                Text(
                  formattedDate,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.appLabelColor,
                  ),
                ),
                const SizedBox(height: 8),
                // Breadcrumbs
                Row(
                  children: [
                    TextButton(
                      onPressed: () => context.go('/apply-now'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Home',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.appButtonColor,
                        ),
                      ),
                    ),
                    Text(
                      ' > ',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.appLabelColor,
                      ),
                    ),
                    Text(
                      'Email verification',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.appLabelColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Success Content
                Center(
                  child: Column(
                    children: [
                      Text(
                        'SUCCESS',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.appTitleBlack,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Icon(
                        Icons.check_circle,
                        size: 120,
                        color: AppColors.green,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Email Verified successfully.',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.appTitleBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Continue Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => context.go('/processing-loader'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appButtonColor,
                      foregroundColor: AppColors.whiteAppColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
