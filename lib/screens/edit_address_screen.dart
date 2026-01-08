import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';

/// Screen 6: Edit Address - Document Selection
/// Features: Document selection for address proof (Aadhaar Card)
class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({super.key});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  String? _selectedDocument;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteAppColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteAppColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.appTitleBlack),
          onPressed: () => context.go('/address-details'),
        ),
        title: const Text(
          'Edit Address',
          style: TextStyle(
            color: AppColors.appTitleBlack,
            fontWeight: FontWeight.bold,
          ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose any one of these documents that has your current address proof.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textfieldColor,
                  ),
                ),
                const SizedBox(height: 24),
                _buildDocumentOption('Aadhaar Card', Icons.badge),
                const SizedBox(height: 32),
                // Button should always be visible when option is selected
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectedDocument != null
                        ? () {
                            // Handle Get Address
                            context.go('/address-details');
                          }
                        : null,
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
                      'Get Address',
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

  Widget _buildDocumentOption(String label, IconData icon) {
    final isSelected = _selectedDocument == label;
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedDocument = label;
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
              value: label,
              groupValue: _selectedDocument,
              onChanged: (value) {
                setState(() {
                  _selectedDocument = value;
                });
              },
              activeColor: AppColors.hdbBlue,
            ),
            const SizedBox(width: 12),
            Icon(icon, color: AppColors.hdbBlue, size: 28),
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

