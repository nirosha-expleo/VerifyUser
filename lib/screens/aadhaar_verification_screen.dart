import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';
import 'package:verifyuser/utility/navigation_helper.dart';
import 'package:verifyuser/widgets/hdb_logo.dart';
import 'package:verifyuser/widgets/verification_overlay.dart';
import 'dart:html' as html show window;

import 'package:verifyuser/widgets/verification_popup.dart';

/// Aadhaar Verification Screen
/// Features: Aadhaar verification with popup and web redirect to 3rd party service
class AadhaarVerificationScreen extends StatefulWidget {
  const AadhaarVerificationScreen({super.key});

  @override
  State<AadhaarVerificationScreen> createState() => _AadhaarVerificationScreenState();
}

class _AadhaarVerificationScreenState extends State<AadhaarVerificationScreen> {
  bool _isVerifying = false;
  bool _isVerified = false;

  void _showVerificationPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => VerificationOverlay(
        title: 'Aadhaar Verification',
        description: 'Verify your Aadhaar and fetch address details',
        icon: Icons.credit_card,
        iconColor: AppColors.appButtonColor,
        redirectUrl: 'https://uidai.gov.in/',
        steps: [
          const VerificationStep(
            title: 'Enter Aadhaar Number',
            description: 'Provide your 12-digit Aadhaar number',
          ),
          const VerificationStep(
            title: 'OTP Verification',
            description: 'Enter OTP sent to your registered mobile',
          ),
          const VerificationStep(
            title: 'Redirect to UIDAI',
            description: 'You will be redirected to UIDAI portal',
          ),
          const VerificationStep(
            title: 'Fetch Address',
            description: 'Your address will be fetched from Aadhaar',
          ),
          const VerificationStep(
            title: 'Verification Complete',
            description: 'Address fetched successfully',
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
            const Text(
              'Aadhaar verified successfully!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Your address has been fetched from Aadhaar.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/address-details');
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
        title: const Text(
          'Aadhaar Verification',
          style: TextStyle(
            color: AppColors.appTitleBlack,
            fontWeight: FontWeight.bold,
          ),
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
                  'Verify Aadhaar',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.appTitleBlack,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Verify your Aadhaar to fetch address details',
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
                        Icons.credit_card,
                        size: 64,
                        color: AppColors.appButtonColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Aadhaar Card',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'XXXX XXXX XXXX',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
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
                              'Verify Aadhaar',
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
                    'Aadhaar Verified Successfully',
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

