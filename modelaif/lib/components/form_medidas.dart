import 'package:flutter/material.dart';

import 'package:modelaif/medidas.dart';

class FormMedidas extends StatefulWidget {
  final Map<String, dynamic> tabelaPadrao;

  const FormMedidas(this.tabelaPadrao, {super.key});

  @override
  State<FormMedidas> createState() => _FormMedidasState();
}

class _FormMedidasState extends State<FormMedidas> {
  Map<String, dynamic>? tabela;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    tabela = Map.from(widget.tabelaPadrao);
    tabela?.nome = widget.tabelaPadrao['nome'] ?? 'Sem nome';

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
    required dynamic value,
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
