import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Navigation Helper Utility
/// Provides safe navigation methods that handle cases where pop is not possible
class NavigationHelper {
  /// Safely pops the current route, or navigates to a fallback route
  static void safePop(BuildContext context, {String? fallbackRoute}) {
    if (context.canPop()) {
      context.pop();
    } else if (fallbackRoute != null) {
      context.go(fallbackRoute);
    } else {
      // Default fallback to apply-now
      context.go('/apply-now');
    }
  }

  /// Gets the logical previous route based on current route
  static String? getPreviousRoute(String currentRoute) {
    final routeMap = {
      '/address-details': '/personal-details',
      '/personal-details': '/pan-dob-selection',
      '/pan-dob-selection': '/otp-verification',
      '/otp-verification': '/apply-now',
      '/edit-address': '/address-details',
      '/email-verification-sent': '/address-details',
      '/email-verified': '/email-verification-sent',
      '/pan-verification': '/pan-dob-selection',
      '/aadhaar-verification': '/edit-address',
      '/digilocker-verification': '/personal-details',
      '/verification-flow/pan': '/pan-dob-selection',
      '/verification-flow/aadhaar': '/edit-address',
      '/verification-flow/digilocker': '/personal-details',
      '/offer': '/email-verified',
      '/loading': '/email-verified',
    };

    // Handle dynamic routes
    if (currentRoute.startsWith('/verification-flow/')) {
      final type = currentRoute.split('/').last.split('?').first;
      if (type == 'pan') return '/pan-dob-selection';
      if (type == 'aadhaar') return '/edit-address';
      if (type == 'digilocker') return '/personal-details';
    }

    return routeMap[currentRoute.split('?').first] ?? '/apply-now';
  }

  /// Safely pops with automatic fallback based on current route
  static void smartPop(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;
    final previousRoute = getPreviousRoute(currentRoute);
    safePop(context, fallbackRoute: previousRoute);
  }
}

