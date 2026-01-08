import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  static double getMobileMaxWidth(BuildContext context) {
    return MediaQuery.of(context).size.width < 600
        ? MediaQuery.of(context).size.width
        : 600;
  }

  static double getTabletMaxWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return width;
    } else if (width < 1200) {
      return width;
    } else {
      return 1200;
    }
  }

  static EdgeInsets getScreenPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(16.0);
    } else if (isTablet(context)) {
      return const EdgeInsets.all(24.0);
    } else {
      return const EdgeInsets.symmetric(horizontal: 48.0, vertical: 24.0);
    }
  }

  static double getFontSize(BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }
}

