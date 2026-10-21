import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';

import 'package:ifmoldes/medidas.dart';
import 'package:ifmoldes/data/medidas.dart';
import 'package:ifmoldes/models.dart';

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
    final tabelaPadraoModel = TabelaDeMedidasModel(
      nome: 'Medidas padrão',
      dataCriacao: DateTime(0),
      ultimaModificacao: DateTime(0),
      tabela: widget.tabelaPadrao,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      color: theme.colorScheme.surfaceContainer,
      child: Form(
        child: Column(
          spacing: 8,
          children: [
            SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 16),
                  ),
                  shadowColor: WidgetStatePropertyAll<Color>(
                    Colors.transparent,
                  ),
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    return Colors.transparent;
                  }),
                  controller: controller,
                  leading: Icon(Icons.design_services_outlined),
                  trailing: [Icon(Icons.search_outlined)],
                  hintText: tabelaPadraoModel.nome,
                  hintStyle: WidgetStateProperty.resolveWith((states) {
                    return theme.textTheme.bodyLarge;
                  }),
                  onTap: () {
                    controller.openView();
                  },
                );
              },
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                    final List<TabelaDeMedidasModel> tabelaModels =
                        [tabelaPadraoModel] +
                        tabelaModelsExemplo
                            .where(
                              (TabelaDeMedidasModel tabela) =>
                                  removeDiacritics(tabela.nome.toLowerCase())
                                      .contains(
                                        removeDiacritics(
                                          controller.text.toLowerCase(),
                                        ),
                                      ),
                            )
                            .toList();
                    final List<ListTile> listTiles = tabelaModels.map((
                      selecionada,
                    ) {
                      return ListTile(
                        title: Text(selecionada.nome),
                        onTap: () {
                          controller.closeView(selecionada.nome);
                          for (final entry in controllers.entries) {
                            if (selecionada.tabela.containsKey(entry.key)) {
                              controllers[entry.key]!.text = selecionada
                                  .tabela[entry.key]!
                                  .toString();
                            }
                          }
                        },
                      );
                    }).toList();
                    return listTiles;
                  },
            ),
            Column(
              spacing: 8,
              children: tabela
                  .toList()
                  .map(
                    (par) => _buildInputField(
                      label: par.key,
                      value: par.value,
                      controller: controllers[par.key]!,
                    ),
                  )
                  .toList(),
            ),
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
