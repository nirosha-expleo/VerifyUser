import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';
import 'package:verifyuser/widgets/hdb_logo.dart';
import 'package:verifyuser/utility/navigation_helper.dart';

/// Loan Offer Screen
/// Features: Secured and Unsecured loan options with expand/collapse, EMI calculator
class LoanOfferScreen extends StatefulWidget {
  const LoanOfferScreen({super.key});

  @override
  State<LoanOfferScreen> createState() => _LoanOfferScreenState();
}

class _LoanOfferScreenState extends State<LoanOfferScreen> {
  bool _isSecuredExpanded = false;
  bool _isUnsecuredExpanded = false;
  bool _isAccepted = false;
  bool _isRejected = false;
  
  // Secured Loan (Non-editable)
  final double _securedPLAmount = 700000;
  final double _securedPOSAmount = 171405;
  final double _securedROI = 22;
  final String _securedProduct = 'AL';
  final int _securedTenure = 60;
  final double _securedEMI = 20959;

  // Unsecured Loan (Editable)
  double _unsecuredLoanAmount = 300000;
  final double _unsecuredMinAmount = 50000;
  final double _unsecuredMaxAmount = 500000; // 5 lakh
  final int _unsecuredTenure = 60;
  final double _unsecuredROI = 22;
  double _unsecuredEMI = 8983;

  @override
  void initState() {
    super.initState();
    _calculateUnsecuredEMI();
  }

  void _calculateUnsecuredEMI() {
    final principal = _unsecuredLoanAmount;
    final rate = _unsecuredROI / 12 / 100;
    final months = _unsecuredTenure.toDouble();
    final power = _pow(1 + rate, months.toInt());
    final emi = (principal * rate * power) / (power - 1);
    setState(() {
      _unsecuredEMI = emi.isFinite ? emi.roundToDouble() : 0;
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

  void _handleAccept() {
    // Navigate to final offer acceptance screen
    context.go('/offer-accepted');
  }

  void _handleReject() {
    // Navigate to reject success screen
    context.go('/offer-rejected');
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
        title: const Text(
          'Offer',
          style: TextStyle(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppLogo(),
                  const SizedBox(height: 32),
                  // Total Loan Amount
                  Text(
                    'Total Loan Amount',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textfieldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: TextEditingController(text: '1000000'),
                    readOnly: true,
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
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Secured Loan Section
                  _buildLoanSection(
                    title: 'Secured Loan',
                    isExpanded: _isSecuredExpanded,
                    onToggle: () {
                      setState(() {
                        _isSecuredExpanded = !_isSecuredExpanded;
                      });
                    },
                    child: _buildSecuredLoanContent(),
                  ),
                  const SizedBox(height: 16),
                  // Unsecured Loan Section
                  _buildLoanSection(
                    title: 'Unsecured Loan',
                    isExpanded: _isUnsecuredExpanded,
                    onToggle: () {
                      setState(() {
                        _isUnsecuredExpanded = !_isUnsecuredExpanded;
                      });
                    },
                    child: _buildUnsecuredLoanContent(),
                  ),
                  const SizedBox(height: 32),
                  // Accept/Reject Radio Buttons
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: _isAccepted,
                        onChanged: (value) {
                          if (value == true) {
                            setState(() {
                              _isAccepted = true;
                              _isRejected = false;
                            });
                          }
                        },
                        activeColor: AppColors.appButtonColor,
                      ),
                      const Text('Accept'),
                      const SizedBox(width: 32),
                      Radio<bool>(
                        value: true,
                        groupValue: _isRejected,
                        onChanged: (value) {
                          if (value == true) {
                            setState(() {
                              _isRejected = true;
                              _isAccepted = false;
                            });
                          }
                        },
                        activeColor: AppColors.appButtonColor,
                      ),
                      const Text('Reject'),
                    ],
                  ),
                  // Action Buttons - Only show when radio button is selected
                  if (_isAccepted || _isRejected) ...[
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isAccepted ? null : _handleReject,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.inputFieldBackground,
                              foregroundColor: AppColors.appTitleBlack,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              disabledBackgroundColor: AppColors.disableAppColor,
                            ),
                            child: const Text(
                              'Reject',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isRejected ? null : _handleAccept,
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
                              'Accept',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoanSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.inputFieldBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.inputFieldBorder),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.appTitleBlack,
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: AppColors.appTitleBlack,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: child,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSecuredLoanContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildReadOnlyField('PL offer amount.', _formatCurrency(_securedPLAmount)),
        const SizedBox(height: 16),
        _buildReadOnlyField('POS amount', _formatCurrency(_securedPOSAmount)),
        const SizedBox(height: 16),
        _buildReadOnlyField('ROI', '$_securedROI%'),
        const SizedBox(height: 16),
        _buildReadOnlyField('Product', _securedProduct),
        const SizedBox(height: 16),
        _buildReadOnlyField('Tenure', '$_securedTenure months'),
        const SizedBox(height: 16),
        _buildReadOnlyField('EMI', _formatCurrency(_securedEMI)),
      ],
    );
  }

  Widget _buildUnsecuredLoanContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top up amount slider
        Text(
          'Select your top up amount',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              _formatCurrency(_unsecuredMinAmount),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Expanded(
              child: Slider(
                value: _unsecuredLoanAmount,
                min: _unsecuredMinAmount,
                max: _unsecuredMaxAmount,
                divisions: ((_unsecuredMaxAmount - _unsecuredMinAmount) / 10000).round(),
                label: _formatCurrency(_unsecuredLoanAmount),
                activeColor: AppColors.appButtonColor,
                onChanged: (value) {
                  setState(() {
                    _unsecuredLoanAmount = value;
                    _calculateUnsecuredEMI();
                  });
                },
              ),
            ),
            Text(
              _formatCurrency(_unsecuredMaxAmount),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Tenure
        _buildEditableField(
          'Tenure',
          '$_unsecuredTenure',
          (value) {
            // Can be made editable if needed
          },
        ),
        const SizedBox(height: 24),
        // Summary Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.adColorlight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Loan Amount',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.appLabelColor,
                ),
              ),
              Text(
                _formatCurrency(_unsecuredLoanAmount),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(height: 24),
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
                        '$_unsecuredTenure months',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
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
                        '$_unsecuredROI% per annum',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 24),
              Text(
                'Monthly EMI',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.appLabelColor,
                ),
              ),
              Text(
                _formatCurrency(_unsecuredEMI),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
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
          readOnly: true,
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
          ),
        ),
      ],
    );
  }

  Widget _buildEditableField(String label, String value, Function(String) onChanged) {
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
          readOnly: true,
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
          ),
        ),
      ],
    );
  }
}

