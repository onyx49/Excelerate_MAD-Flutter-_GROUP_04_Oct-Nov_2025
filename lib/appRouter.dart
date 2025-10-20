import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/login.dart';
import 'screens/signup.dart';

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
  ],
);