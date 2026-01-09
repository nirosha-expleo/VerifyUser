import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';
import 'package:verifyuser/utility/navigation_helper.dart';
import 'package:verifyuser/widgets/hdb_logo.dart';
import 'package:intl/intl.dart';

/// Screen 3: PAN or Date of Birth Selection
/// Features: Radio buttons for PAN/DOB, PAN input with validation, DOB calendar picker, Submit button
class PanDobSelectionScreen extends StatefulWidget {
  const PanDobSelectionScreen({super.key});

  @override
  State<PanDobSelectionScreen> createState() => _PanDobSelectionScreenState();
}

class _PanDobSelectionScreenState extends State<PanDobSelectionScreen> {
  String _selectedOption = 'dob'; // 'pan' or 'dob'
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime? _selectedDate;
  bool _dataConsent = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _panController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  String? _validatePAN(String? value) {
    if (value == null || value.isEmpty) {
      return 'PAN number is required';
    }
    // PAN format: ABCDE1234F (5 letters, 4 digits, 1 letter)
    final panPattern = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
    if (!panPattern.hasMatch(value.toUpperCase())) {
      return 'Please enter a valid PAN (e.g., ABCDE1234F)';
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 25)), // Default to 25 years ago
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.appButtonColor,
              onPrimary: AppColors.whiteAppColor,
              onSurface: AppColors.appTitleBlack,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      if (_selectedOption == 'dob' && !_dataConsent) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please accept data consent'),
            backgroundColor: AppColors.redAccent,
          ),
        );
        return;
      }
      
      // If PAN is selected, redirect to PAN verification flow
      if (_selectedOption == 'pan' && _panController.text.isNotEmpty) {
        context.go('/verification-flow/pan?pan=${_panController.text.toUpperCase()}');
      } else {
        // For DOB, go directly to personal details
        context.go('/personal-details');
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
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
            child: Column(
              children: [
                    const AppLogo(),
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
                    // Conditional PAN Input
                    if (_selectedOption == 'pan') ...[
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                          'PAN Number*',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textfieldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                      TextFormField(
                        controller: _panController,
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                        ],
                        validator: _validatePAN,
                    decoration: InputDecoration(
                          hintText: 'Enter PAN (e.g., ABCDE1234F)',
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
                    ),
                      ),
                    ],
                    // Conditional DOB Input
                    if (_selectedOption == 'dob') ...[
                      const SizedBox(height: 24),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Date of Birth*',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textfieldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _dobController,
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        decoration: InputDecoration(
                          hintText: 'Select Date of Birth (DD/MM/YYYY)',
                          filled: true,
                          fillColor: AppColors.inputFieldBackground,
                          suffixIcon: const Icon(Icons.calendar_today),
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
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Date of Birth is required';
                          }
                          return null;
                        },
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
                            activeColor: AppColors.appButtonColor,
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
                        onPressed: _handleSubmit,
                    style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.appButtonColor,
                      foregroundColor: AppColors.whiteAppColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
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
            color: isSelected ? AppColors.appButtonColor : AppColors.inputFieldBorder,
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
              activeColor: AppColors.appButtonColor,
            ),
            const SizedBox(width: 12),
            Icon(
              icon,
              color: AppColors.appButtonColor,
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
