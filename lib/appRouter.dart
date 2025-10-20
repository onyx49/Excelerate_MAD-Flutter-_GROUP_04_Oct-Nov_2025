import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/home_page.dart';

// This file contains all screen paths for navigation
final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/', // Start at login screen
      builder: (context, state) => const loginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const signupScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        final role = state.extra as String?;
        final bool isLearner = role == 'Learner';
        return DashboardPage(isLearner: isLearner);
      },
    )
  ],
);