import 'package:flutter/material.dart';

import 'package:ifmoldes/components/back_bar.dart';
import 'package:ifmoldes/components/link.dart';

const String isencaoDeResponsabilidadeText =
    'Aplicativo desenvolvido por docentes e discentes do IFRN para fins educacionais e acadêmicos. Não se trata de um aplicativo de prestação de serviços públicos oficiais do Governo Federal.';

class SobreScreen extends StatelessWidget {
  const SobreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final backBar = BackBar(title: 'Sobre', context: context);
    final theme = Theme.of(context);
    const gap = SizedBox(height: 8,);

    return Scaffold(
      appBar: backBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4, 
            children: [
              Center(child: Image.asset('assets/logo-96dpi.png', height: 96,)),
              gap,
              Center(child: Image.asset('assets/logo.png', height: 24,)),
              Center(child: Text('Versão 1.0.0', style: theme.textTheme.bodySmall)),
              gap,
              Text(
                'Isenção de responsabilidade',
                style: theme.textTheme.titleLarge,
              ),
              Text(isencaoDeResponsabilidadeText),
              gap,
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
              gap,
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