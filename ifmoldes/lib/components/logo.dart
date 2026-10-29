import 'package:flutter/material.dart';

const logoWidth = 150.0;

final imgIFMoldes = Image.asset('assets/logo-96dpi.png', width: logoWidth);

/// Retorna a logo como título.
/// O [baselineFix] serve para alinhar as duas partes do texto, pois são de fontes diferentes.
class LogoIFMoldes extends StatelessWidget {
  /// Usado para corrigir a altura da linha do texto, já que as fontes são diferentes.
  final double baselineFix;

  /// Cor da logo.
  final Color color;

  const new({ super.key, this.color = Colors.black, this.baselineFix = 20 });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Baseline(
          // Este baseline compensa a diferença de altura entre as fontes
          baseline: baselineFix,
          baselineType: TextBaseline.alphabetic,
          child: Text(
            'IF',
            style: TextStyle(
              color: color, // Color.fromARGB(255, 101, 101, 101),
              fontWeight: FontWeight.w600,
              fontFamily: 'Open Sans',
            ),
          ),
        ),
        Text(
          'Moldes',
          style: TextStyle(
            color: color, // Color.fromARGB(255, 50, 160, 65),
            fontWeight: FontWeight.bold,
            fontFamily: 'Outfit',
          ),
        ),
      ],
    );
  }
}
