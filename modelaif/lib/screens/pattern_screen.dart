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
    final parteWidgets = molde.partes
        .map((parte) => ParteWidget(parte))
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
              child: FormMedidas(molde.medidasPadrao),
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

  const ParteWidget(this.parte, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final decoration = BoxDecoration(
      color: theme.colorScheme.primaryContainer,
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
            PassosWidget(parte.passos),
          ],
        ),
      ),
    );
  }
}

class PassosWidget extends StatelessWidget {
  final List<Passo> passos;

  const PassosWidget(this.passos, {super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];
    for (int i = 0; i < passos.length; i++) {
      Passo p = passos[i];
      Widget w = Text('${i+1}. ${p.descricao}');
      widgets.add(w);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}


class FormMedidas extends StatefulWidget {
  final TabelaDeMedidas tabela;

  const FormMedidas(this.tabela, {super.key});

  @override
  State<FormMedidas> createState() => _FormMedidasState();
}

class _FormMedidasState extends State<FormMedidas> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: theme.colorScheme.surfaceContainer,
      child: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Icon(Icons.design_services_outlined),
                  SizedBox(width: 12),
                  Text('Medidas', style: theme.textTheme.titleMedium),
                ],
              ),
            ),
            Column(
              spacing: 8,
              children: widget.tabela.toList().map(
                (par) => _buildInputField(label: par.key, value: par.value),
              ).toList(),
            ),
            // TODO: Atualizar de acordo com novo protótipo no Figma. Usar uma search bar.
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Medidas Salvas',
                style: theme.textTheme.titleMedium,
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: theme.colorScheme.outlineVariant,
                indent: 16,
                endIndent: 16,
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  leading: Icon(Icons.design_services_outlined),
                  title: Text('Perfil $index'),
                  subtitle: Text('(data)'),
                  trailing: Icon(Icons.upload_outlined),
                  onTap: () {},
                );
              },
            ),
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
