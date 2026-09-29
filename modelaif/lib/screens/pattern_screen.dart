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
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: FormMedidas(molde.medidasPadrao),
              ),
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
    return ExpansionTile(
      initiallyExpanded: true,
      backgroundColor: theme.colorScheme.surfaceContainer,
      collapsedBackgroundColor: theme.colorScheme.surfaceContainer,
      tilePadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      iconColor: theme.colorScheme.onSurfaceVariant,
      collapsedIconColor: theme.colorScheme.onSurfaceVariant,
      title: Row(
        children: [
          Icon(
            Icons.design_services_outlined,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: 12),
          Text(
            'Medidas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: Column(
            spacing: 8,
            children: widget.tabela.toList().map(
              (par) => _buildInputField(label: par.key, value: par.value),
            ).toList(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            'Medidas Salvas',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
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
              leading: Icon(
                Icons.design_services_outlined,
                size: 20,
              ),
              title: Text(
                'Perfil $index',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                '(data)',
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.upload_outlined,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                onPressed: () {},
              ),
            );
          },
        ),
      ],
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
        labelStyle: const TextStyle(color: Colors.black87, fontSize: 14),
        suffixText: 'cm',
        suffixStyle: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: const Color(0xFFF3F6EC),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEBB2C3), width: 1.5),
        ),
        /*suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: Colors.black45,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    controller.clear();
                  });
                },
              )
            : null,*/
      ),
      onChanged: (_) => setState(() {}),
    );
  }
}
