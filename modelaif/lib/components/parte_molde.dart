import 'package:flutter/material.dart';
import 'package:modelaif/molde.dart';
import 'package:modelaif/medidas.dart';

class ParteWidget extends StatelessWidget {
  final Parte parte;

  final TabelaDeMedidas tabelaDeMedidas;

  const ParteWidget(this.parte, this.tabelaDeMedidas, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final decoration = BoxDecoration(
      color: theme.colorScheme.secondaryContainer,
      borderRadius: BorderRadius.all(Radius.circular(16)),
    );

    return Container(
      decoration: decoration,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Possibilitar carregar a imagem do banco ou arquivo .mif
            Image.asset(parte.imagem),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              child: Text(parte.nome, style: theme.textTheme.labelLarge),
            ),
            Text(
              'Cortar: x${parte.quantidade}',
              style: theme.textTheme.bodyMedium,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: parte.passos.length,
              itemBuilder: (context, index) {
                Passo passo = parte.passos[index];
                List<Widget> children = [Text('${index + 1}. ${passo.descricao}')];
                if (passo.medidaProporcional(tabelaDeMedidas) > 0) {
                  String c = passo.medida ?? '';
                  c += passo.divisor != 1 ? ' / ${passo.divisor}' : '';
                  c += passo.incremento != 0 ? ' + ${passo.incremento}cm' : '';
                  c +=  ' = ${passo.medidaProporcional(tabelaDeMedidas)}cm';
                  children.add(Text(c));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}