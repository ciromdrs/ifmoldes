import 'package:flutter/material.dart';
import 'package:modelaif/components/pattern_card.dart';
import 'package:modelaif/molde.dart';
import 'package:modelaif/screens/pattern_screen.dart';

class CardsPadding extends StatelessWidget {
  // Moldes do Grid
  final List<Molde> _moldes = moldesExemplo;

  CardsPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GridView.builder(
        itemCount: _moldes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final Molde molde = _moldes[index];
          return AnimatedPatternCard(
            title: molde.modelo,
            onTap: () {
              // Navegação para a PatternScreen passando o molde
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PatternScreen(molde),
                ),
              );
            },
          );
        },
      ),
    );
  }
}