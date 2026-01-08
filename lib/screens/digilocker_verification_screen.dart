import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';
import 'package:verifyuser/utility/navigation_helper.dart';
import 'package:verifyuser/widgets/hdb_logo.dart';
import 'package:verifyuser/widgets/verification_overlay.dart';
import 'dart:html' as html show window;

import 'package:verifyuser/widgets/verification_popup.dart';

/// DigiLocker Verification Screen
/// Features: DigiLocker integration with popup and web redirect
class DigiLockerVerificationScreen extends StatefulWidget {
  const DigiLockerVerificationScreen({super.key});

  @override
  State<DigiLockerVerificationScreen> createState() => _DigiLockerVerificationScreenState();
}

class _DigiLockerVerificationScreenState extends State<DigiLockerVerificationScreen> {
  bool _isConnecting = false;
  bool _isConnected = false;

  void _showDigiLockerPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => VerificationOverlay(
        title: 'DigiLocker',
        description: 'Document Wallet to Empower Citizens',
        icon: Icons.cloud_download,
        iconColor: AppColors.green,
        redirectUrl: 'https://accounts.digitallocker.gov.in/signin/oauth_partner',
        steps: [
          const VerificationStep(
            title: 'Sign In to DigiLocker',
            description: 'Enter your mobile number or Aadhaar',
          ),
          const VerificationStep(
            title: 'OTP Verification',
            description: 'Verify with OTP sent to your mobile',
          ),
          const VerificationStep(
            title: 'Select Account',
            description: 'Choose your DigiLocker account if multiple exist',
          ),
          const VerificationStep(
            title: 'Authorize Access',
            description: 'Grant permission to access your documents',
          ),
          const VerificationStep(
            title: 'Fetch Documents',
            description: 'Documents will be fetched from DigiLocker',
          ),
        ],
        onSuccess: (data) {
          Navigator.of(context).pop(); // Close overlay
          setState(() {
            _isConnecting = false;
            _isConnected = true;
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
        title: const Text('DigiLocker Connected'),
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
              'Successfully connected to DigiLocker!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Your documents have been fetched.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
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
        title: const Text(
          'DigiLocker',
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
                  'Connect DigiLocker',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.appTitleBlack,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Fetch your documents from DigiLocker',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textfieldColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.green, width: 2),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'DL',
                            style: TextStyle(
                              color: AppColors.whiteAppColor,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'DigiLocker',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Document Wallet to Empower Citizens',
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                if (!_isConnected)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _showDigiLockerPopup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        foregroundColor: AppColors.whiteAppColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isConnecting
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
                              'Connect DigiLocker',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                if (_isConnected) ...[
                  const Icon(
                    Icons.check_circle,
                    size: 64,
                    color: AppColors.green,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'DigiLocker Connected',
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

