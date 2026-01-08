import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';
import 'package:verifyuser/widgets/hdb_logo.dart';

/// Screen 1: Apply Now - Initial loan application screen
/// Features: Mobile number input, Terms & Conditions checkbox, GET OTP button
class ApplyNowScreen extends StatefulWidget {
  const ApplyNowScreen({super.key});

  @override
  State<ApplyNowScreen> createState() => _ApplyNowScreenState();
}

class _ApplyNowScreenState extends State<ApplyNowScreen> {
  final TextEditingController _mobileController = TextEditingController(text: '9984384097');
  bool _termsAccepted = false;

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  void _handleGetOtp() {
    if (_mobileController.text.isNotEmpty && _termsAccepted) {
      context.go('/otp-verification');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return Scaffold(
      backgroundColor: AppColors.whiteAppColor,
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
                const HDBLogo(),
                const SizedBox(height: 32),
                Text(
                  'Apply Now',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.appTitleBlack,
                  ),
                ),
                const SizedBox(height: 32),
                // Mobile Number Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mobile Number*',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textfieldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.inputFieldBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.inputFieldBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.inputFieldBorder),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.hdbBlue, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Terms & Conditions Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          _termsAccepted = value ?? false;
                        });
                      },
                      activeColor: AppColors.hdbGreen,
                    ),
                    Expanded(
                      child: Text(
                        'I have read and agree to all the Terms & Conditions',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textfieldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // GET OTP Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _termsAccepted ? _handleGetOtp : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.hdbBlue,
                      foregroundColor: AppColors.whiteAppColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      disabledBackgroundColor: AppColors.disableAppColor,
                    ),
                    child: const Text(
                      'GET OTP',
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

