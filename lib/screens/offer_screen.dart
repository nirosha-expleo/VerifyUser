import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';
import 'package:verifyuser/utility/navigation_helper.dart';
import 'package:verifyuser/widgets/hdb_logo.dart';

/// Offer Screen with EMI Calculator
class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  final TextEditingController _loanAmountController = TextEditingController(text: '500000');
  final TextEditingController _interestRateController = TextEditingController(text: '12');
  final TextEditingController _tenureController = TextEditingController(text: '60');
  double _emiAmount = 0;

  @override
  void initState() {
    super.initState();
    _calculateEMI();
  }

  @override
  void dispose() {
    _loanAmountController.dispose();
    _interestRateController.dispose();
    _tenureController.dispose();
    super.dispose();
  }

  void _calculateEMI() {
    final principal = double.tryParse(_loanAmountController.text) ?? 0;
    final rate = double.tryParse(_interestRateController.text) ?? 0;
    final tenure = double.tryParse(_tenureController.text) ?? 0;

    if (principal > 0 && rate > 0 && tenure > 0) {
      final monthlyRate = rate / 12 / 100;
      final months = tenure.toInt();
      final power = _pow(1 + monthlyRate, months);
      final emi = (principal * monthlyRate * power) / (power - 1);
      setState(() {
        _emiAmount = emi.isFinite ? emi : 0;
      });
    } else {
      setState(() {
        _emiAmount = 0;
      });
    }
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const AppLogo(),
                  const SizedBox(height: 32),
                  Text(
                    'Special Offers',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.appTitleBlack,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Offer Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.adColorlight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.appButtonColor, width: 2),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_offer,
                          size: 48,
                          color: AppColors.appButtonColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Pre-approved Loan Offer',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.appTitleBlack,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Loan Amount: ₹XX,XX,XXX',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.textfieldColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Interest Rate: XX% p.a.',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.textfieldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'EMI Calculator',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.appTitleBlack,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(
                    'Loan Amount (₹)',
                    _loanAmountController,
                    TextInputType.number,
                    onChanged: _calculateEMI,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'Interest Rate (% p.a.)',
                    _interestRateController,
                    TextInputType.number,
                    onChanged: _calculateEMI,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'Tenure (Months)',
                    _tenureController,
                    TextInputType.number,
                    onChanged: _calculateEMI,
                  ),
                  const SizedBox(height: 24),
                  // EMI Result
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.appButtonColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Monthly EMI',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.whiteAppColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '₹${_emiAmount.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: AppColors.whiteAppColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.go('/personal-details'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.appButtonColor,
                        foregroundColor: AppColors.whiteAppColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Apply Now',
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

  Widget _buildTextField(String label, TextEditingController controller, TextInputType keyboardType, {VoidCallback? onChanged}) {
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
          controller: controller,
          keyboardType: keyboardType,
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
              borderSide: const BorderSide(color: AppColors.appButtonColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}


