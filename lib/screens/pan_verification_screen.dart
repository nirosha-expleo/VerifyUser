import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';
import 'package:verifyuser/utility/navigation_helper.dart';
import 'package:verifyuser/widgets/hdb_logo.dart';
import 'package:verifyuser/widgets/verification_overlay.dart';
import 'dart:html' as html show window;

import 'package:verifyuser/widgets/verification_popup.dart';

/// PAN Verification Screen
/// Features: PAN verification with popup and web redirect to 3rd party service
class PanVerificationScreen extends StatefulWidget {
  final String? panNumber;
  
  const PanVerificationScreen({super.key, this.panNumber});

  @override
  State<PanVerificationScreen> createState() => _PanVerificationScreenState();
}

class _PanVerificationScreenState extends State<PanVerificationScreen> {
  bool _isVerifying = false;
  bool _isVerified = false;

  void _showVerificationPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => VerificationOverlay(
        title: 'PAN Verification',
        description: 'Verify your PAN number through Income Tax portal',
        icon: Icons.badge,
        iconColor: AppColors.appButtonColor,
        redirectUrl: 'https://incometaxindia.gov.in/pan/',
        steps: [
          const VerificationStep(
            title: 'Enter PAN Details',
            description: 'Provide your PAN number for verification',
          ),
          const VerificationStep(
            title: 'Redirect to Verification Service',
            description: 'You will be redirected to Income Tax portal',
          ),
          const VerificationStep(
            title: 'Complete Verification',
            description: 'Follow the instructions on the verification portal',
          ),
          const VerificationStep(
            title: 'Authorize Data Access',
            description: 'Grant permission to fetch your PAN details',
          ),
          const VerificationStep(
            title: 'Verification Complete',
            description: 'Your PAN has been verified successfully',
          ),
        ],
        onSuccess: (data) {
          Navigator.of(context).pop(); // Close overlay
          setState(() {
            _isVerifying = false;
            _isVerified = true;
          });
          _showSuccessDialog();
        },
        onCancel: () {
          Navigator.of(context).pop(); // Close overlay
        },
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Verification Successful'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              size: 64,
              color: AppColors.green,
            ),
            const SizedBox(height: 16),
            Text(
              'PAN ${widget.panNumber ?? 'XXXXX1234X'} verified successfully!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/personal-details');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.appButtonColor,
            ),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                const AppLogo(),
                const SizedBox(height: 32),
                Text(
                  'PAN Verification',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.appTitleBlack,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Verify your PAN number to proceed',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textfieldColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.adColorlight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.appButtonColor, width: 2),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.badge,
                        size: 64,
                        color: AppColors.appButtonColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'PAN Number',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.panNumber ?? 'XXXXX1234X',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.appButtonColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                if (!_isVerified)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _showVerificationPopup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.appButtonColor,
                        foregroundColor: AppColors.whiteAppColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isVerifying
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.whiteAppColor,
                                ),
                              ),
                            )
                          : const Text(
                              'Verify PAN',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                if (_isVerified) ...[
                  const Icon(
                    Icons.check_circle,
                    size: 64,
                    color: AppColors.green,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'PAN Verified Successfully',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

