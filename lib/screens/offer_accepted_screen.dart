import 'package:flutter/material.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';
import 'package:verifyuser/widgets/hdb_logo.dart';

/// Offer Accepted Screen
/// Final screen after accepting loan offer with language selection for KFS Document
class OfferAcceptedScreen extends StatefulWidget {
  const OfferAcceptedScreen({super.key});

  @override
  State<OfferAcceptedScreen> createState() => _OfferAcceptedScreenState();
}

class _OfferAcceptedScreenState extends State<OfferAcceptedScreen> {
  String? _selectedLanguage;
  bool _isDocumentSent = false;
  final List<String> _languages = [
    'English',
    'Hindi',
    'Tamil',
    'Telugu',
    'Kannada',
    'Malayalam',
    'Bengali',
    'Gujarati',
    'Marathi',
  ];

  // Loan details (from previous screen)
  final double _sanctionAmount = 200000;
  final int _duration = 60;
  final double _roi = 20;
  double _monthlyEMI = 0; // Will be calculated

  @override
  void initState() {
    super.initState();
    _calculateEMI();
  }

  void _calculateEMI() {
    final principal = _sanctionAmount;
    final rate = _roi / 12 / 100;
    final months = _duration.toDouble();
    final power = _pow(1 + rate, months.toInt());
    final emi = (principal * rate * power) / (power - 1);
    setState(() {
      _monthlyEMI = emi.isFinite ? emi.roundToDouble() : 0;
    });
  }

  double _pow(double base, int exponent) {
    if (exponent == 0) return 1.0;
    if (exponent < 0) return 1.0 / _pow(base, -exponent);
    double result = 1.0;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }

  String _formatCurrency(double amount) {
    final formatted = amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return 'Rs.$formatted/-';
  }

  void _handleSendDocument() {
    setState(() {
      _isDocumentSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteAppColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteAppColor,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove back button
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
                children: [
                  const SizedBox(height: 32),
                  // Success Icon
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: AppColors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 60,
                      color: AppColors.whiteAppColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Congratulations, Your loan is now APPROVED',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.appTitleBlack,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  // Loan Details Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.adColorlight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sanction Amount',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.appLabelColor,
                          ),
                        ),
                        Text(
                          _formatCurrency(_sanctionAmount),
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.appTitleBlack,
                          ),
                        ),
                        const Divider(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Duration',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.appLabelColor,
                                  ),
                                ),
                                Text(
                                  '$_duration months',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.appTitleBlack,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'ROI',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.appLabelColor,
                                  ),
                                ),
                                Text(
                                  '$_roi% per annum',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.appTitleBlack,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(height: 32),
                        Text(
                          'Monthly EMI',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.appLabelColor,
                          ),
                        ),
                        Text(
                          _monthlyEMI > 0 ? _formatCurrency(_monthlyEMI) : 'Rs. /-',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.appTitleBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Language Selection
                  Text(
                    'Select the preferred language for KFS Document',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.appTitleBlack,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedLanguage,
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
                        borderSide: const BorderSide(color: AppColors.appButtonColor, width: 2),
                      ),
                      hintText: 'Select Preferred Language',
                    ),
                    items: _languages.map((language) {
                      return DropdownMenuItem<String>(
                        value: language,
                        child: Text(language),
                      );
                    }).toList(),
                    onChanged: _isDocumentSent ? null : (value) {
                      setState(() {
                        _selectedLanguage = value;
                      });
                    },
                  ),
                  // Send Button - Show only when language is selected and document not sent
                  if (_selectedLanguage != null && !_isDocumentSent) ...[
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleSendDocument,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.appButtonColor,
                          foregroundColor: AppColors.whiteAppColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Send',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                  // Success Message - Show after document is sent
                  if (_isDocumentSent) ...[
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.green, width: 2),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: AppColors.green,
                            size: 32,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Successfully sent document to your mail',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

