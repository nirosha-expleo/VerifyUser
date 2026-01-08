import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';
import 'package:verifyuser/widgets/hdb_logo.dart';

/// Screen 4: Personal Details Form
/// Features: Full name, PAN, DOB, Name as per PAN, Father Name, Email
class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const HDBLogo(),
                  const SizedBox(height: 32),
                  Text(
                    'Personal Details',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.appTitleBlack,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildTextField(context, 'Full name*', 'DHARMENDRA KUMAR CHAUDHARY'),
                  const SizedBox(height: 16),
                  _buildTextField(context, 'PAN number', 'AJEPC3578N'),
                  const SizedBox(height: 16),
                  _buildTextField(context, 'Date of Birth', '01/07/1982'),
                  const SizedBox(height: 16),
                  _buildTextField(context, 'Name As Per PAN*', 'hariharan'),
                  const SizedBox(height: 16),
                  _buildTextField(context, 'Father Name As Per PAN*', 'Chaudhary'),
                  const SizedBox(height: 16),
                  _buildTextField(context, 'Email ID', 'rekha.ravi@expleogroup.com'),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.go('/address-details'),
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
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label, String value) {
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

