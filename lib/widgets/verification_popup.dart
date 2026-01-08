import 'package:flutter/material.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'dart:html' as html show window;

/// Verification Popup Widget
/// Shows verification steps in a popup dialog
class VerificationPopup extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final String redirectUrl;
  final VoidCallback? onSuccess;
  final List<VerificationStep> steps;

  const VerificationPopup({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.redirectUrl,
    this.onSuccess,
    this.steps = const [],
  });

  void _redirectToService() {
    // Open in new window/tab
    html.window.open(redirectUrl, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            // Steps (if provided) - Show all 5 steps
            if (steps.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Verification Process (${steps.length} steps)',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.appLabelColor,
                ),
              ),
              const SizedBox(height: 12),
              ...steps.asMap().entries.map((entry) {
                final index = entry.key;
                final step = entry.value;
                return _buildStep(context, index + 1, step);
              }),
              const SizedBox(height: 16),
            ],
            // Redirect Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _redirectToService();
                  if (onSuccess != null) {
                    Future.delayed(const Duration(seconds: 2), () {
                      if (context.mounted) {
                        Navigator.of(context).pop();
                        onSuccess!();
                      }
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: iconColor,
                  foregroundColor: AppColors.whiteAppColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Continue to Verification',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, int stepNumber, VerificationStep step) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: step.isCompleted
                  ? AppColors.green
                  : AppColors.appButtonColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: step.isCompleted
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: AppColors.whiteAppColor,
                    )
                  : Text(
                      '$stepNumber',
                      style: const TextStyle(
                        color: AppColors.whiteAppColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (step.description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    step.description!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.appLabelColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VerificationStep {
  final String title;
  final String? description;
  final bool isCompleted;

  const VerificationStep({
    required this.title,
    this.description,
    this.isCompleted = false,
  });
}

