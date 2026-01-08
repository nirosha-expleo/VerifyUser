import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verifyuser/screens/apply_now_screen.dart';
import 'package:verifyuser/screens/otp_verification_screen.dart';
import 'package:verifyuser/screens/pan_dob_selection_screen.dart';
import 'package:verifyuser/screens/personal_details_screen.dart';
import 'package:verifyuser/screens/address_details_screen.dart';
import 'package:verifyuser/screens/edit_address_screen.dart';
import 'package:verifyuser/screens/email_verification_sent_screen.dart';
import 'package:verifyuser/screens/email_verified_screen.dart';
import 'package:verifyuser/screens/loading_screen.dart';
import 'package:verifyuser/screens/document_viewer_screen.dart';
import 'package:verifyuser/screens/screen1.dart';
import 'package:verifyuser/screens/screen2.dart';
import 'package:verifyuser/screens/screen3.dart';
import 'package:verifyuser/screens/screen4.dart';
import 'package:verifyuser/screens/screen5.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/apply-now',
    routes: [
      // Main Application Flow
      GoRoute(
        path: '/apply-now',
        builder: (context, state) => const ApplyNowScreen(),
      ),
      GoRoute(
        path: '/otp-verification',
        builder: (context, state) => const OTPVerificationScreen(),
      ),
      GoRoute(
        path: '/pan-dob-selection',
        builder: (context, state) => const PanDobSelectionScreen(),
      ),
      GoRoute(
        path: '/personal-details',
        builder: (context, state) => const PersonalDetailsScreen(),
      ),
      GoRoute(
        path: '/address-details',
        builder: (context, state) => const AddressDetailsScreen(),
      ),
      GoRoute(
        path: '/edit-address',
        builder: (context, state) => const EditAddressScreen(),
      ),
      GoRoute(
        path: '/email-verification-sent',
        builder: (context, state) => const EmailVerificationSentScreen(),
      ),
      GoRoute(
        path: '/email-verified',
        builder: (context, state) => const EmailVerifiedScreen(),
      ),
      GoRoute(
        path: '/loading',
        builder: (context, state) => const LoadingScreen(),
      ),
      // Document Viewer (for navigation/testing)
      GoRoute(
        path: '/document-viewer',
        builder: (context, state) => const DocumentViewerScreen(),
      ),
      // Placeholder screens (can be removed later)
      GoRoute(
        path: '/screen1',
        builder: (context, state) => const Screen1(),
      ),
      GoRoute(
        path: '/screen2',
        builder: (context, state) => const Screen2(),
      ),
      GoRoute(
        path: '/screen3',
        builder: (context, state) => const Screen3(),
      ),
      GoRoute(
        path: '/screen4',
        builder: (context, state) => const Screen4(),
      ),
      GoRoute(
        path: '/screen5',
        builder: (context, state) => const Screen5(),
      ),
    ],
  );
}

