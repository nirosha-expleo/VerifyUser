import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/config/app_router.dart';
import 'package:verifyuser/config/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const VerifyUserApp());
}

class VerifyUserApp extends StatelessWidget {
  const VerifyUserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'VerifyUser',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}

