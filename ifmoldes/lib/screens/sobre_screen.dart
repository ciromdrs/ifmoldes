import 'package:flutter/material.dart';

import 'package:ifmoldes/components/back_bar.dart';

class SobreScreen extends StatelessWidget {
  const SobreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final backBar = BackBar(title: 'Sobre', context: context);

    final logoWidth = mediaQuery.size.width * .35;

    return Scaffold(
      appBar: backBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/logo.png',
              width: logoWidth,
              height: logoWidth
            ),
          ),
          Text('IF Moldes', style: TextStyle(fontSize: 26)),
          Text('Versão 1.0.0', style: TextStyle(fontSize: 10)),
          Padding(
            padding: EdgeInsets.only(top: 12, bottom: 6, left: 18, right: 18),
            child: SizedBox(
              width: mediaQuery.size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6.0,
                children: [
                  Text('Licença', style: TextStyle(fontSize: 24)),
                  Text('Desenvolvido com Material Design 3.', style: TextStyle(fontSize: 12))
                ],
              )
            )
          )
        ],
      )
    );
  }
}