import 'package:flutter/material.dart';
import 'appRouter.dart';

void main() {
  runApp(const CollabEaseApp());
}

class CollabEaseApp extends StatelessWidget {
  const CollabEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'CollabEase',
      routerConfig: appRouter,
        );
  }
}


