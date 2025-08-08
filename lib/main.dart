import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/app_theme.dart';
import 'core/app_router.dart';

void main() {
  runApp(JostarProgrammingApp());
}

class JostarProgrammingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Jostar Programming - Mobile App & Website Solutions',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}