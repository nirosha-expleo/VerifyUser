import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';
import 'package:verifyuser/utility/navigation_helper.dart';

/// Screen 7: Email Verification Link Sent
/// Features: Envelope icon, confirmation message, auto-redirect to loader
class EmailVerificationSentScreen extends StatefulWidget {
  const EmailVerificationSentScreen({super.key});

  @override
  State<EmailVerificationSentScreen> createState() => _EmailVerificationSentScreenState();
}

class _EmailVerificationSentScreenState extends State<EmailVerificationSentScreen> {
  int _currentStep = 0;
  bool _showLoader = false;
  final List<String> _steps = [
    'Verifying your details...',
    'Checking eligibility...',
    'Calculating loan offers...',
    'Preparing your offers...',
  ];

  @override
  void initState() {
    super.initState();
    // Show loader after 3 seconds on the same screen
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showLoader = true;
        });
        _startProcessing();
      }
    });
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
    final email = 'xxxxx@xxxxx.com'; // Dummy data
    
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.mail,
                    size: 120,
                    color: AppColors.appButtonColor,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Email verification link has been sent to',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textfieldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    email,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.appButtonColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please verify the same to get your loan approved.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textfieldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "TnC's applicable.",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.appLabelColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Loader appears below TnC text
                  if (_showLoader) ...[
                    const SizedBox(height: 48),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.appButtonColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          // Loading indicator
                          Container(
                            width: 80,
                            height: 80,
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
                          const SizedBox(height: 24),
                          // Current step text
                          Text(
                            _currentStep < _steps.length
                                ? _steps[_currentStep]
                                : 'Almost done...',
                            style: const TextStyle(
                              color: AppColors.whiteAppColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          // Steps indicator
                          Column(
                            children: _steps.asMap().entries.map((entry) {
                              final index = entry.key;
                              final step = entry.value;
                              final isCompleted = index < _currentStep;
                              final isCurrent = index == _currentStep;
                              
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
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
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
