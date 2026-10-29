import 'package:flutter/material.dart';

import 'package:ifmoldes/components/back_bar.dart';
import 'package:ifmoldes/components/link.dart';
import 'package:ifmoldes/components/logo.dart';

const String isencaoDeResponsabilidadeText =
    'Aplicativo desenvolvido por docentes e discentes do IFRN para fins educacionais e acadêmicos. Não se trata de um aplicativo de prestação de serviços públicos oficiais do Governo Federal.';

class SobreScreen extends StatelessWidget {
  const SobreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final backBar = BackBar(title: 'Sobre', context: context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: backBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: imgIFMoldes),
              Center(child: LogoIFMoldes(fontSize: theme.textTheme.headlineLarge!.fontSize, baselineFix: 34,)),
              Center(child: Text('Versão 1.0.0', style: theme.textTheme.bodySmall)),
              SizedBox(height: 12,), // Apenas um pouco de gap
              Text(
                'Isenção de responsabilidade',
                style: theme.textTheme.titleLarge,
              ),
              Text(isencaoDeResponsabilidadeText),
              Text('Links úteis', style: theme.textTheme.titleLarge),
              Link(
                text: 'Repositório oficial',
                destination: 'https://github.com/ciromdrs/ifmoldes',
              ),
              Link(
                text: 'Licença',
                destination:
                    'https://github.com/ciromdrs/ifmoldes/blob/main/LICENSE',
              ),
              Link(
                text: 'Política de Privacidade',
                destination: 'https://example.com',
              ),
              Text('Recursos de terceiros', style: theme.textTheme.titleLarge),
              Wrap(
                children: [
                  Text('Desenvolvido com '),
                  Link(
                    text: 'Material Design.',
                    destination: 'https://m3.material.io/',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}