import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';

/// Processing Loader Screen
/// Shows multiple loading sections before redirecting to offer screen
class ProcessingLoaderScreen extends StatefulWidget {
  const ProcessingLoaderScreen({super.key});

  @override
  State<ProcessingLoaderScreen> createState() => _ProcessingLoaderScreenState();
}

class _ProcessingLoaderScreenState extends State<ProcessingLoaderScreen> {
  int _currentStep = 0;
  final List<String> _steps = [
    'Verifying your details...',
    'Checking eligibility...',
    'Calculating loan offers...',
    'Preparing your offers...',
  ];

  @override
  void initState() {
    super.initState();
    _startProcessing();
  }

  void _startProcessing() {
    // Process each step
    for (int i = 0; i < _steps.length; i++) {
      Future.delayed(Duration(seconds: 2 + (i * 2)), () {
        if (mounted) {
          setState(() {
            _currentStep = i + 1;
          });
          
          // After last step, redirect to offer screen
          if (i == _steps.length - 1) {
            Future.delayed(const Duration(seconds: 1), () {
              if (mounted) {
                context.go('/offer-screen');
              }
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appButtonColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Loading indicator
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.whiteAppColor,
                  width: 3,
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteAppColor),
                  strokeWidth: 3,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Current step text
            Text(
              _currentStep < _steps.length
                  ? _steps[_currentStep]
                  : 'Almost done...',
              style: const TextStyle(
                color: AppColors.whiteAppColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            // Steps indicator
            Column(
              children: _steps.asMap().entries.map((entry) {
                final index = entry.key;
                final step = entry.value;
                final isCompleted = index < _currentStep;
                final isCurrent = index == _currentStep;
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? AppColors.green
                              : isCurrent
                                  ? AppColors.whiteAppColor
                                  : AppColors.whiteAppColor.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: isCompleted
                            ? const Icon(
                                Icons.check,
                                size: 16,
                                color: AppColors.whiteAppColor,
                              )
                            : isCurrent
                                ? const Center(
                                    child: SizedBox(
                                      width: 12,
                                      height: 12,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColors.appButtonColor,
                                        ),
                                      ),
                                    ),
                                  )
                                : null,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        step,
                        style: TextStyle(
                          color: isCompleted || isCurrent
                              ? AppColors.whiteAppColor
                              : AppColors.whiteAppColor.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

