import 'package:flutter/material.dart';
import 'package:ifmoldes/screens/home_screen.dart'; // Import com o caminho da pasta screens

void main() {
  runApp(const IFMoldesApp());
}

class IFMoldesApp extends StatelessWidget {
  const IFMoldesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IF Moldes',
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