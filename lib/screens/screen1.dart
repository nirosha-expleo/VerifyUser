import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/utility/app_colors.dart';
import 'package:verifyuser/utility/responsive_helper.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 1 - Welcome'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/document-viewer'),
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
                    Icons.verified_user,
                    size: isMobile ? 80 : 120,
                    color: AppColors.appButtonColor,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Welcome to VerifyUser',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'This is the first screen of the document viewer application.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => context.go('/screen2'),
                    child: const Text('Next Screen'),
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

