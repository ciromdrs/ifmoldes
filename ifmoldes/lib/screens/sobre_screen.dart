import 'package:flutter/material.dart';

import 'package:ifmoldes/components/back_bar.dart';

class SobreScreen extends StatelessWidget {
  const SobreScreen({super.key});

  final String isencaoDeResponsabilidadeText = 'Aplicativo desenvolvido por docentes e discentes do IFRN para fins educacionais e acadêmicos. Não se trata de um aplicativo de prestação de serviços públicos oficiais do Governo Federal.';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final backBar = BackBar(title: 'Sobre', context: context);

    final logoWidth = mediaQuery.size.width * .35;

    const double subtitlesSize = 24;
    const double textsSize = 16;

    Widget itemList(String text) {
      return Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Row(
          spacing: 12.0,
          children: [
            Text('•', style: TextStyle(fontSize: textsSize + 8)),
            Text(text, style: TextStyle(fontSize: textsSize)),
          ],
        )
      );
    }

    return Scaffold(
      appBar: backBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/logo-96dpi.png',
                width: logoWidth,
                height: logoWidth
              ),
            ),
            Text('IF Moldes', style: TextStyle(fontSize: subtitlesSize)),
            Text('Versão 1.0.0', style: TextStyle(fontSize: 10)),
            Padding(
              padding: EdgeInsets.only(top: 12, bottom: 6, left: 18, right: 18),
              child: SizedBox(
                width: mediaQuery.size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2.0,
                  children: [
                    Text('Isenção de responsabilidade', style: TextStyle(fontSize: subtitlesSize)),
                    Text(isencaoDeResponsabilidadeText, style: TextStyle(fontSize: textsSize))
                  ],
                )
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 12, bottom: 6, left: 18, right: 18),
              child: SizedBox(
                width: mediaQuery.size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2.0,
                  children: [
                    Text('Links úteis', style: TextStyle(fontSize: subtitlesSize)),
                    itemList('Repositório oficial'),
                    itemList('Licença'),
                    itemList('Política de Privacidade'),
                  ],
                )
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 12, bottom: 6, left: 18, right: 18),
              child: SizedBox(
                width: mediaQuery.size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 6.0,
                  children: [
                    Text('Recursos de terceiros', style: TextStyle(fontSize: subtitlesSize)),
                    itemList('Desenvolvido com Material Design.'),
                  ],
                )
              )
            ),
          ]
        ),
      )
    );
  }
}