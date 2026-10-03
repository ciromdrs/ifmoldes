import 'package:flutter/material.dart';
import 'package:modelaif/screens/home_screen.dart'; // Import com o caminho da pasta screens
import 'package:modelaif/screens/sobre_screen.dart';

void main() {
  runApp(const ModelaIFApp());
}

class ModelaIFApp extends StatelessWidget {
  const ModelaIFApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ModelaIF',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00CC4D)
        ),

        textTheme: const TextTheme(
          labelLarge: TextStyle(
            fontWeight: FontWeight.w700,
          ),
          labelMedium: TextStyle(
            fontWeight: FontWeight.w500,
          ),
          labelSmall: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}