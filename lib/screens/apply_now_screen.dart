import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';
import 'package:verifyuser/widgets/hdb_logo.dart';

/// Screen 1: Apply Now - Initial loan application screen
/// Features: Mobile number input with +91 country code, Terms & Conditions checkbox, GET OTP button
class ApplyNowScreen extends StatefulWidget {
  const ApplyNowScreen({super.key});

  @override
  State<ApplyNowScreen> createState() => _ApplyNowScreenState();
}

class _ApplyNowScreenState extends State<ApplyNowScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _termsAccepted = false;
  String? _mobileError;

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    // Remove spaces and check if it's exactly 10 digits
    final cleaned = value.replaceAll(' ', '');
    if (cleaned.length != 10) {
      return 'Please enter a valid 10-digit mobile number';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(cleaned)) {
      return 'Mobile number should contain only digits';
    }
    return null;
  }

  void _handleGetOtp() {
    if (!_termsAccepted) {
      context.go('/error?title=Terms Not Accepted&message=Please accept Terms & Conditions to continue');
      return;
    }
    
    if (_formKey.currentState!.validate()) {
      // Clear any previous errors
      setState(() {
        _mobileError = null;
      });
      context.go('/otp-verification');
    } else {
      // Show error if validation fails
      final mobile = _mobileController.text;
      if (mobile.isEmpty) {
        context.go('/error?title=Invalid Mobile Number&message=Mobile number is required. Please enter a valid 10-digit mobile number.');
      } else if (mobile.length != 10) {
        context.go('/error?title=Invalid Mobile Number&message=Mobile number must be exactly 10 digits. Please enter a valid mobile number.');
      } else {
        context.go('/error?title=Invalid Mobile Number&message=Please enter a valid 10-digit mobile number.');
      }
    }
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
          onPressed: () => context.go('/'),
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppLogo(),
                  const SizedBox(height: 32),
                  Text(
                    'Apply Now',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.appTitleBlack,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Mobile Number Field with +91
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
                  TextFormField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: _validateMobile,
                    decoration: InputDecoration(
                      prefixText: '+91 ',
                      prefixStyle: const TextStyle(
                        color: AppColors.textfieldColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
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
                        borderSide: const BorderSide(color: AppColors.appButtonColor, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.redAccent, width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.redAccent, width: 2),
                      ),
                      counterText: '',
                      hintText: 'Enter 10 digit mobile number',
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
                        activeColor: AppColors.appButtonColor,
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
                        backgroundColor: AppColors.appButtonColor,
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
      ),
    );
  }
}
