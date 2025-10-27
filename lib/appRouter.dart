// import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_04_app/model/jsonmodel.dart';
import 'screens/program_listing.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/home_page.dart';
import 'screens/courses_enrolled_page.dart';

// This file contains all screen paths for navigation
final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/', // Start at login screen
      builder: (context, state) {
        return LoginScreen();
      }
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const signupScreen(),
    ),
    GoRoute(
      path: '/program_listing',
      builder: (context, state) 
        {
        final isLearner = state.extra as bool? ?? false;
        return ProgramsPage(isLearner: isLearner);
      },
      
    ),

    GoRoute(
  path: '/courses_enrolled_page',
  builder: (context, state) {
    final Userjsonmodel user = state.extra as Userjsonmodel;
    return CoursesEnrolledPage(user: user);
  },
),
    
    GoRoute(
      path: '/home_page',
      builder: (context, state) {
        
        // final bool isLearner = role == 'Learner';

        final data = state.extra as Map<String, dynamic>?;

        if (data == null) {
          // fallback in case of direct access
          return  DashboardPage(isLearner: true, currentUser: Userjsonmodel(email: "" ),);
        }

        final role = data['role'] as String? ?? 'Learner';
        
        final email = data['email'] as String? ?? '';

        final bool isLearner = role.toLowerCase() == 'learner';

        // Create a user model instance
        final user = Userjsonmodel(
           // optional — or replace with real id from Firebase
         
          email: email,
          role: role,
         
        );

        return DashboardPage(isLearner: isLearner , currentUser: user);
      },
    )
  ],
);