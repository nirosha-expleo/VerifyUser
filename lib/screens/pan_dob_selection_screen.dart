import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';
import 'package:verifyuser/widgets/hdb_logo.dart';

/// Screen 3: PAN or Date of Birth Selection
/// Features: Radio buttons for PAN/DOB, conditional DOB input, Submit button
class PanDobSelectionScreen extends StatefulWidget {
  const PanDobSelectionScreen({super.key});

  @override
  State<PanDobSelectionScreen> createState() => _PanDobSelectionScreenState();
}

class _PanDobSelectionScreenState extends State<PanDobSelectionScreen> {
  String _selectedOption = 'dob'; // 'pan' or 'dob'
  final TextEditingController _dobController = TextEditingController();
  bool _dataConsent = false;

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
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
                  'PAN or Date of Birth',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.appTitleBlack,
                  ),
                ),
                const SizedBox(height: 32),
                // PAN Option
                _buildOption(
                  context,
                  value: 'pan',
                  label: 'PAN',
                  icon: Icons.badge,
                ),
                const SizedBox(height: 16),
                // Date of Birth Option
                _buildOption(
                  context,
                  value: 'dob',
                  label: 'Date of Birth',
                  icon: Icons.calendar_today,
                ),
                // Conditional DOB Input
                if (_selectedOption == 'dob') ...[
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'DOB*',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textfieldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _dobController,
                    decoration: InputDecoration(
                      hintText: 'Enter your DOB (DD/MM/YYYY)',
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
                  // Data Consent Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _dataConsent,
                        onChanged: (value) {
                          setState(() {
                            _dataConsent = value ?? false;
                          });
                        },
                        activeColor: AppColors.hdbBlue,
                      ),
                      Expanded(
                        child: Text(
                          'Willing to use the data for processing your loan application',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textfieldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 32),
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (_selectedOption == 'dob' && _dobController.text.isEmpty) || 
                              (_selectedOption == 'dob' && !_dataConsent)
                        ? null
                        : () {
                            context.go('/personal-details');
                          },
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
                      'Submit',
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

  Widget _buildOption(BuildContext context, {
    required String value,
    required String label,
    required IconData icon,
  }) {
    final isSelected = _selectedOption == value;
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedOption = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.hdbBlue : AppColors.inputFieldBorder,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? AppColors.adColorlight : AppColors.whiteAppColor,
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: _selectedOption,
              onChanged: (val) {
                setState(() {
                  _selectedOption = val ?? value;
                });
              },
              activeColor: AppColors.hdbBlue,
            ),
            const SizedBox(width: 12),
            Icon(
              icon,
              color: AppColors.hdbBlue,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.appTitleBlack,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

