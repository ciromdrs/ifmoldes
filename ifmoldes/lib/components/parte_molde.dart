import 'package:flutter/material.dart';
import 'package:ifmoldes/medidas.dart';
import 'package:ifmoldes/molde.dart';

class ParteWidget extends StatefulWidget {
  final Parte parte;

  final TabelaDeMedidas tabelaDeMedidas;

  final Map<String, TextEditingController> controllers;

  const ParteWidget(
    this.parte,
    this.tabelaDeMedidas,
    this.controllers, {
    super.key,
  });

  @override
  State<ParteWidget> createState() => _ParteWidgetState();
}

class _ParteWidgetState extends State<ParteWidget> {
  late Parte parte;
  late TabelaDeMedidas tabelaDeMedidas;
  late Map<String, TextEditingController> controllers;

  @override
  initState() {
    super.initState();
    parte = widget.parte;
    tabelaDeMedidas = widget.tabelaDeMedidas;
    controllers = Map.from(widget.controllers);

    for (final pair in controllers.entries) {
      pair.value.addListener(() {
        setState(() {
          tabelaDeMedidas[pair.key] = double.parse(pair.value.text);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final decoration = BoxDecoration(
      color: theme.colorScheme.surfaceContainer,
      borderRadius: BorderRadius.all(Radius.circular(16)),
      border: Border.all(color: theme.colorScheme.outlineVariant, width: 2,)
    );

    return Container(
      decoration: decoration,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            // TODO: Possibilitar carregar a imagem do banco ou arquivo .mif
            Image.asset(parte.imagem),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(parte.nome, style: theme.textTheme.headlineMedium),
            ),
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiary,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 4,
                  children: [
                    Icon(
                      Icons.cut,
                      size: 18,
                      color: theme.colorScheme.onTertiary,
                    ),
                    Text(
                      'x${parte.quantidade}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 1, // The height of the divider
                    color: theme.colorScheme.outlineVariant, // The color of the divider
                    thickness: 1, // The thickness of the divider line
                    indent: 8, // The left padding (indent) of the divider
                    endIndent: 8, // The right padding (endIndent) of the divider
                  );
                },
                itemCount: parte.passos.length,
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: PassoWidget(
                    passo: parte.passos[index],
                    ordem: index + 1,
                    tabelaDeMedidas: tabelaDeMedidas,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PassoWidget extends StatelessWidget {
  final Passo passo;
  final int ordem;
  final TabelaDeMedidas tabelaDeMedidas;

  const PassoWidget({
    required this.passo,
    required this.ordem,
    required this.tabelaDeMedidas,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 8,
          children: [
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Text(
                '$ordemº',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(passo.descricao),
                  CalculoWidget(passo, tabelaDeMedidas)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculoWidget extends StatelessWidget {
  // Padding vertical do container que exibe o cálculo e a medida proporcional
  // resultante. Garante o alinhamento em ambos os lados da equação.
  static const paddingVertical = EdgeInsets.symmetric(vertical: 2);
  final Passo passo;
  final TabelaDeMedidas tabelaDeMedidas;

  const CalculoWidget(this.passo, this.tabelaDeMedidas, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String calculo = '';

    // Exibe apenas os valores relevantes no cálculo:
    // Medida de referência
    if (passo.medida != null) {
      // Nunca será null aqui, mas somos obrigados a colocar o valor padrão
      calculo += passo.medida ?? '';
    }
    // Divisor
    if (passo.divisor != 1) {
      calculo += ' / ${passo.divisor}';
    }
    // Incremento
    if (passo.incremento != 0) {
      if (calculo.isNotEmpty) {
        calculo += ' + ';
      }
      calculo += '${passo.incremento}cm';
    }
    
    // Widgets que compõem o cálculo da medida proporcional
    List<Widget> childrenCalculo = [];
    // Booleanos auxiliares
    bool temCalculo = calculo.isNotEmpty;
    bool temResultado = calculo.isNotEmpty;
    if (temCalculo) {
      childrenCalculo.add(Text(
        calculo,
        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)
      ));
    }
    // Se há um cálculo relevante e o resultado é calculável, adiciona o '='
    if (temCalculo && temResultado) {
      childrenCalculo.add(Text('='));
    }

    return Wrap(
      spacing: 4,
      alignment: WrapAlignment.center,
      children: [
        Padding(
          padding: paddingVertical,
          child: Wrap(
            spacing: 4,
            children: childrenCalculo
          )
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.all(Radius.circular(4))
          ),
          padding: paddingVertical + EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '${passo.medidaProporcional(tabelaDeMedidas) ?? 0}cm',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
      ]
    );
  } 
}