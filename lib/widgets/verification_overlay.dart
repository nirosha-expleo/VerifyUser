import 'package:flutter/material.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/widgets/verification_popup.dart';
import 'dart:html' as html show window;

/// Verification Overlay Widget
/// Shows verification in an iframe overlay on current screen
class VerificationOverlay extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final String redirectUrl;
  final List<VerificationStep> steps;
  final Function(Map<String, dynamic>)? onSuccess;
  final VoidCallback? onCancel;

  const VerificationOverlay({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.redirectUrl,
    this.steps = const [],
    this.onSuccess,
    this.onCancel,
  });

  @override
  State<VerificationOverlay> createState() => _VerificationOverlayState();
}

class _VerificationOverlayState extends State<VerificationOverlay> {
  bool _isLoading = true;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    // Simulate loading
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _handleSuccess() {
    // Simulate fetching data
    final data = {
      'verified': true,
      'timestamp': DateTime.now().toIso8601String(),
    };
    widget.onSuccess?.call(data);
  }

  void _handleCancel() {
    widget.onCancel?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.9,
        constraints: const BoxConstraints(maxWidth: 800),
        decoration: BoxDecoration(
          color: AppColors.whiteAppColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.iconColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: widget.iconColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(widget.icon, color: AppColors.whiteAppColor, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.description,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _handleCancel,
                    tooltip: 'Close',
                  ),
                ],
              ),
            ),
            // Steps Indicator
            if (widget.steps.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.adColorlight,
                  border: Border(
                    bottom: BorderSide(color: AppColors.inputFieldBorder),
                  ),
                ),
                child: Row(
                  children: widget.steps.asMap().entries.map((entry) {
                    final index = entry.key;
                    final step = entry.value;
                    final isActive = index == _currentStep;
                    final isCompleted = index < _currentStep;
                    return Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? AppColors.green
                                  : isActive
                                      ? widget.iconColor
                                      : AppColors.appLabelColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: isCompleted
                                  ? const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: AppColors.whiteAppColor,
                                    )
                                  : Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        color: AppColors.whiteAppColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          if (index < widget.steps.length - 1)
                            Expanded(
                              child: Container(
                                height: 2,
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                color: isCompleted
                                    ? AppColors.green
                                    : AppColors.appLabelColor,
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            // Content Area - iframe or simulated content
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.inputFieldBorder),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: _buildVerificationContent(),
                      ),
                    ),
            ),
            // Footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.inputFieldBorder),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _handleCancel,
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _handleSuccess,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.iconColor,
                      foregroundColor: AppColors.whiteAppColor,
                    ),
                    child: const Text('Complete Verification'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationContent() {
    // In a real implementation, this would be an iframe
    // For now, showing a simulated verification interface
    return Container(
      color: AppColors.whiteAppColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              size: 80,
              color: widget.iconColor,
            ),
            const SizedBox(height: 24),
            Text(
              'Verification Service',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'This is a simulated verification interface.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'In production, this would load the actual verification service in an iframe.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.appLabelColor,
              ),
            ),
            const SizedBox(height: 32),
            // Simulated form fields
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.adColorlight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter verification details',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Additional information',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Click "Complete Verification" to proceed',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.appLabelColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

