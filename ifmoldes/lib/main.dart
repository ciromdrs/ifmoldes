import 'package:flutter/material.dart';
import 'package:ifmoldes/screens/home_screen.dart'; // Import com o caminho da pasta screens

void main() async {
  runApp(const IFMoldesApp());
}

class IFMoldesApp extends StatelessWidget {
  const IFMoldesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF00CC4D),
    );
    return MaterialApp(
      title: 'IF Moldes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        textTheme: const TextTheme(
          labelLarge: TextStyle(fontWeight: FontWeight.w700),
          labelMedium: TextStyle(fontWeight: FontWeight.w500),
          labelSmall: TextStyle(fontWeight: FontWeight.w500),
        ),
        appBarTheme: AppBarTheme(shadowColor: colorScheme.shadow),
      ),
      home: const HomeScreen(),
    );
  }
}
