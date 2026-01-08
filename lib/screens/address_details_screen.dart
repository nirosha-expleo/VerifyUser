import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';
import 'package:verifyuser/widgets/hdb_logo.dart';

/// Screen 5: Address Details Form
/// Features: Address lines, Pincode, City, State with loading overlay
class AddressDetailsScreen extends StatefulWidget {
  const AddressDetailsScreen({super.key});

  @override
  State<AddressDetailsScreen> createState() => _AddressDetailsScreenState();
}

class _AddressDetailsScreenState extends State<AddressDetailsScreen> {
  bool _isLoadingPincode = false;

  void _fetchPincode() {
    setState(() {
      _isLoadingPincode = true;
    });
    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoadingPincode = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const HDBLogo(),
                      const SizedBox(height: 32),
                      Text(
                        'Address details',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.appTitleBlack,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildTextField(context, 'Address Line 1*', 'VILL ARKHAPUR'),
                      const SizedBox(height: 16),
                      _buildTextField(context, 'Address Line 2*', 'PO CHILMA BAZAR'),
                      const SizedBox(height: 16),
                      _buildTextField(context, 'Address Line 3', 'GAUSPUR'),
                      const SizedBox(height: 16),
                      _buildTextField(context, 'Pincode*', '272301', onChanged: _fetchPincode),
                      const SizedBox(height: 16),
                      _buildTextField(context, 'City*', 'BASTI'),
                      const SizedBox(height: 16),
                      _buildTextField(context, 'State*', 'UTTAR PRADESH'),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.disableAppColor,
                                foregroundColor: AppColors.appLabelColor,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Edit'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => context.go('/email-verification-sent'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.hdbBlue,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Loading Overlay
          if (_isLoadingPincode)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.hdbBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteAppColor),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Please wait while we fetch your pincode.',
                        style: TextStyle(
                          color: AppColors.whiteAppColor,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String label,
    String value, {
    VoidCallback? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textfieldColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value),
          onChanged: onChanged != null ? (_) => onChanged() : null,
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
      ],
    );
  }
}

