import 'package:flutter/material.dart';

import 'package:ifmoldes/medidas.dart';

class FormMedidas extends StatefulWidget {
  final TabelaDeMedidas tabelaPadrao;
  final Map<String, TextEditingController> controllers;

  const FormMedidas(this.tabelaPadrao, this.controllers, {super.key});

  @override
  State<FormMedidas> createState() => _FormMedidasState();
}

class _FormMedidasState extends State<FormMedidas> {
  TabelaDeMedidas tabela = TabelaDeMedidas({});
  late Map<String, TextEditingController> controllers;

  @override
  initState() {
    super.initState();
    controllers = widget.controllers;
    for (final pair in widget.tabelaPadrao.toList()) {
      controllers[pair.key] = TextEditingController();
      controllers[pair.key]!.text = widget.tabelaPadrao[pair.key].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    tabela.copy(widget.tabelaPadrao);

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
              children: tabela.toList().map(
                (par) => _buildInputField(label: par.key, value: par.value, controller: controllers[par.key]!),
              ).toList(),
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
    required dynamic value,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      initialValue: null,
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
