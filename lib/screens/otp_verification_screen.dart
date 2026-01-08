import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';
import 'package:verifyuser/widgets/hdb_logo.dart';
import 'package:verifyuser/widgets/otp_input_field.dart';

/// Screen 2: OTP Verification
/// Features: 6-digit OTP input, resend timer, Verify & Continue button
class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  int _resendTimer = 30; // seconds
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
        _startTimer();
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleVerify() {
    setState(() {
      _isLoading = true;
    });
    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        context.go('/pan-dob-selection');
      }
    });
  }

  String _formatTimer(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final mobileNumber = '9984384097'; // This should come from previous screen
    
    return Scaffold(
      backgroundColor: AppColors.whiteAppColor,
      body: Stack(
        children: [
          Center(
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
                    const HDBLogo(),
                    const SizedBox(height: 32),
                    Text(
                      'OTP Verification',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.appTitleBlack,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'We have sent a six digit code to your mobile number $mobileNumber',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textfieldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    // OTP Input Fields
                    OTPInputField(controllers: _otpControllers),
                    const SizedBox(height: 16),
                    // Resend OTP Timer
                    TextButton(
                      onPressed: _resendTimer == 0
                          ? () {
                              setState(() {
                                _resendTimer = 30;
                              });
                              _startTimer();
                            }
                          : null,
                      child: Text(
                        _resendTimer > 0
                            ? 'Resend OTP in ${_formatTimer(_resendTimer)}'
                            : 'Resend OTP',
                        style: TextStyle(
                          color: _resendTimer > 0
                              ? AppColors.appLabelColor
                              : AppColors.hdbBlue,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Verify & Continue Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleVerify,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.appButtonColor,
                          foregroundColor: AppColors.whiteAppColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _isLoading
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
                                'Verify & Continue',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Note
                    Text(
                      'Note: You are just few steps away from getting a Loan. *T&C apply',
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
          // Loading Overlay
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

