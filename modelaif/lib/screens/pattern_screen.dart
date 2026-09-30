import 'package:flutter/material.dart';
import 'package:modelaif/medidas.dart';

import '../components/back_bar.dart';

import 'package:modelaif/molde.dart';

class PatternScreen extends StatelessWidget {
  final Molde molde;

  const PatternScreen(this.molde, {super.key});

  @override
  Widget build(BuildContext context) {
    final backBar = BackBar(title: molde.modelo, context: context);
    // TODO: Carregar medidas a partir do form.
    final parteWidgets = molde.partes
        .map((parte) => ParteWidget(parte, molde.tabelaPadrao))
        .toList();

    return Scaffold(
      appBar: backBar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: FormMedidas(molde.tabelaPadrao),
            ),
            ...parteWidgets.map(
              (parte) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                child: parte,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

/*
}*/


class FormMedidas extends StatefulWidget {
  final TabelaDeMedidas tabelaPadrao;

  const FormMedidas(this.tabelaPadrao, {super.key});

  @override
  State<FormMedidas> createState() => _FormMedidasState();
}

class _FormMedidasState extends State<FormMedidas> {
  TabelaDeMedidas? tabela;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    tabela = TabelaDeMedidas(
      nome: widget.tabelaPadrao.nome,
      map: Map.from(widget.tabelaPadrao.map)
    );

    return Container(
      padding: const EdgeInsets.all(16),
      color: theme.colorScheme.surfaceContainer,
      child: Form(
        child: Column(
          spacing: 8,
          children: [
            Row(
              spacing: 10,
              children: [
                Icon(Icons.design_services_outlined),
                Text('Medidas', style: theme.textTheme.titleMedium),
              ],
            ),
            Column(
              spacing: 8,
              children: tabela?.toList().map(
                (par) => _buildInputField(label: par.key, value: par.value),
              ).toList() ?? [],
            ),
            // TODO: Adicionar pesquisa de medidas salvas de acordo com protótipo no Figma.
          ],
        ),
      ),
    );
  }

  // WIDGET AUXILIAR GENÉRICO PARA CAMPOS DE TEXTO
  Widget _buildInputField({
    required String label,
    required double value,
    // required TextEditingController controller,
  }) {
    return TextFormField(
      // controller: controller,
      initialValue: value.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        suffixText: 'cm',
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      onChanged: (_) => setState(() {}),
    );
  }
}
