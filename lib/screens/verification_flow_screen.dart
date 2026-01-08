import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';
import 'package:verifyuser/utility/navigation_helper.dart';
import 'package:verifyuser/widgets/hdb_logo.dart';
import 'package:verifyuser/widgets/verification_popup.dart';
import 'package:verifyuser/widgets/verification_overlay.dart';
import 'dart:html' as html show window;

/// Verification Flow Screen with 5 Section Popups
/// Shows step-by-step verification process
class VerificationFlowScreen extends StatefulWidget {
  final String verificationType; // 'pan', 'aadhaar', 'digilocker'
  final String? panNumber;
  
  const VerificationFlowScreen({
    super.key,
    required this.verificationType,
    this.panNumber,
  });

  @override
  State<VerificationFlowScreen> createState() => _VerificationFlowScreenState();
}

class _VerificationFlowScreenState extends State<VerificationFlowScreen> {
  int _currentStep = 0;
  bool _isProcessing = false;
  String? _panNumber;

  final List<VerificationStep> _panSteps = const [
    VerificationStep(
      title: 'Enter PAN Details',
      description: 'Provide your PAN number for verification',
    ),
    VerificationStep(
      title: 'Redirect to Verification Service',
      description: 'You will be redirected to Income Tax portal',
    ),
    VerificationStep(
      title: 'Complete Verification',
      description: 'Follow the instructions on the verification portal',
    ),
    VerificationStep(
      title: 'Authorize Data Access',
      description: 'Grant permission to fetch your PAN details',
    ),
    VerificationStep(
      title: 'Verification Complete',
      description: 'Your PAN has been verified successfully',
      isCompleted: false,
    ),
  ];

  final List<VerificationStep> _aadhaarSteps = const [
    VerificationStep(
      title: 'Enter Aadhaar Number',
      description: 'Provide your 12-digit Aadhaar number',
    ),
    VerificationStep(
      title: 'OTP Verification',
      description: 'Enter OTP sent to your registered mobile',
    ),
    VerificationStep(
      title: 'Redirect to UIDAI',
      description: 'You will be redirected to UIDAI portal',
    ),
    VerificationStep(
      title: 'Fetch Address',
      description: 'Your address will be fetched from Aadhaar',
    ),
    VerificationStep(
      title: 'Verification Complete',
      description: 'Address fetched successfully',
      isCompleted: false,
    ),
  ];

  final List<VerificationStep> _digilockerSteps = const [
    VerificationStep(
      title: 'Sign In to DigiLocker',
      description: 'Enter your mobile number or Aadhaar',
    ),
    VerificationStep(
      title: 'OTP Verification',
      description: 'Verify with OTP sent to your mobile',
    ),
    VerificationStep(
      title: 'Select Account',
      description: 'Choose your DigiLocker account if multiple exist',
    ),
    VerificationStep(
      title: 'Authorize Access',
      description: 'Grant permission to access your documents',
    ),
    VerificationStep(
      title: 'Fetch Documents',
      description: 'Documents will be fetched from DigiLocker',
      isCompleted: false,
    ),
  ];

  List<VerificationStep> get _steps {
    switch (widget.verificationType) {
      case 'pan':
        return _panSteps;
      case 'aadhaar':
        return _aadhaarSteps;
      case 'digilocker':
        return _digilockerSteps;
      default:
        return _panSteps;
    }
  }

  String get _title {
    switch (widget.verificationType) {
      case 'pan':
        return 'PAN Verification';
      case 'aadhaar':
        return 'Aadhaar Verification';
      case 'digilocker':
        return 'DigiLocker Verification';
      default:
        return 'Verification';
    }
  }

  String get _description {
    switch (widget.verificationType) {
      case 'pan':
        return 'Verify your PAN number through Income Tax portal';
      case 'aadhaar':
        return 'Verify your Aadhaar and fetch address details';
      case 'digilocker':
        return 'Connect to DigiLocker to fetch your documents';
      default:
        return 'Complete the verification process';
    }
  }

  String get _redirectUrl {
    switch (widget.verificationType) {
      case 'pan':
        return 'https://incometaxindia.gov.in/pan/';
      case 'aadhaar':
        return 'https://uidai.gov.in/';
      case 'digilocker':
        return 'https://accounts.digitallocker.gov.in/signin/oauth_partner';
      default:
        return 'https://example.com';
    }
  }

  IconData get _icon {
    switch (widget.verificationType) {
      case 'pan':
        return Icons.badge;
      case 'aadhaar':
        return Icons.credit_card;
      case 'digilocker':
        return Icons.cloud_download;
      default:
        return Icons.verified;
    }
  }

  Color get _iconColor {
    switch (widget.verificationType) {
      case 'pan':
        return AppColors.appButtonColor;
      case 'aadhaar':
        return AppColors.appButtonColor;
      case 'digilocker':
        return AppColors.green;
      default:
        return AppColors.appButtonColor;
    }
  }

  void _showVerificationPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => VerificationOverlay(
        title: _title,
        description: _description,
        icon: _icon,
        iconColor: _iconColor,
        redirectUrl: _redirectUrl,
        steps: _steps,
        onSuccess: (data) {
          Navigator.of(context).pop(); // Close overlay
          _handleVerificationSuccess();
        },
        onCancel: () {
          Navigator.of(context).pop(); // Close overlay
        },
      ),
    );
  }

  void _handleVerificationSuccess() {
    setState(() {
      _isProcessing = true;
    });

    // Simulate processing
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        _showSuccessDialog();
      }
    });
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
              '${_title} completed successfully!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _navigateToNextScreen();
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

  void _navigateToNextScreen() {
    switch (widget.verificationType) {
      case 'pan':
        context.go('/personal-details');
        break;
      case 'aadhaar':
        context.go('/address-details');
        break;
      case 'digilocker':
        context.go('/personal-details');
        break;
      default:
        context.pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _panNumber = widget.panNumber;
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
        title: Text(
          _title,
          style: const TextStyle(
            color: AppColors.appTitleBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ResponsiveHelper.getMobileMaxWidth(context),
            ),
            child: Container(
              margin: ResponsiveHelper.getScreenPadding(context),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                const AppLogo(),
                const SizedBox(height: 32),
                Text(
                  _title,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.appTitleBlack,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textfieldColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Show PAN number if available
                if (widget.verificationType == 'pan' && _panNumber != null) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.adColorlight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.badge, color: AppColors.appButtonColor),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'PAN: $_panNumber',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.appButtonColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                // Steps Preview
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.adColorlight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _iconColor, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Verification Steps (${_steps.length})',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ..._steps.asMap().entries.map((entry) {
                        final index = entry.key;
                        final step = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: index <= _currentStep
                                      ? _iconColor
                                      : AppColors.appLabelColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: index < _currentStep
                                      ? const Icon(
                                          Icons.check,
                                          size: 16,
                                          color: AppColors.whiteAppColor,
                                        )
                                      : Text(
                                          '${index + 1}',
                                          style: const TextStyle(
                                            color: AppColors.whiteAppColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      step.title,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (step.description != null) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        step.description!,
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppColors.appLabelColor,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                if (!_isProcessing)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _showVerificationPopup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _iconColor,
                        foregroundColor: AppColors.whiteAppColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Start Verification',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (_isProcessing) ...[
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  const Text('Processing verification...'                  ),
                ],
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}

