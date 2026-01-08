import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';

class Screen5 extends StatelessWidget {
  const Screen5({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 5 - Summary'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/screen4'),
        ),
      ),
      body: Container(
        color: AppColors.backgroundColor,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ResponsiveHelper.getMobileMaxWidth(context),
            ),
            child: Container(
              margin: ResponsiveHelper.getScreenPadding(context),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.whiteAppColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.boxShadowColor,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.summarize,
                    size: isMobile ? 80 : 120,
                    color: AppColors.appButtonColor,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Summary Screen',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'This is the final screen showing a summary of all information.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => context.go('/screen4'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.appCirclebackground,
                          foregroundColor: AppColors.appTitleBlack,
                        ),
                        child: const Text('Previous'),
                      ),
                      ElevatedButton(
                        onPressed: () => context.go('/document-viewer'),
                        child: const Text('Back to Home'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

