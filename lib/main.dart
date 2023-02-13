import 'package:appflutter/screens/open.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SearchNA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.mainTheme,
      home: const ScrollScreen()
    );
  }
}
