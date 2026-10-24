import 'package:flutter/material.dart';

import 'package:ifmoldes/components/back_bar.dart';
import 'package:ifmoldes/models.dart';
import 'package:ifmoldes/screens/medidas_screen.dart';
import 'package:ifmoldes/medidas.dart';

class MedidaScreen extends StatefulWidget {
  final List<TabelaDeMedidasModel> medidaModels;
  final TabelaDeMedidasModel? editModel;

  const MedidaScreen({super.key, required this.medidaModels, this.editModel});

  @override
  State<MedidaScreen> createState() => _MedidaScreenState();
}

class _MedidaScreenState extends State<MedidaScreen> {
  final TextEditingController nomeController = TextEditingController();
  final List<String> listaDeMedidas = MedidasPadrao.toList();
  final Map<String, TextEditingController> medidasControllers = {};
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String title = 'Criar nova medida';
  late List<TabelaDeMedidasModel> medidaModels;
  late TabelaDeMedidasModel? editModel;

  @override
  initState() {
    super.initState();
    medidaModels = widget.medidaModels;
    editModel = widget.editModel;

    for (final String medida in listaDeMedidas) {
      final TextEditingController controller = TextEditingController();
      if (editModel != null) {
        if (editModel!.tabela[medida] != null) {
          controller.text = editModel!.tabela[medida].toString();
        } else {
          controller.text = '';
        }
      }

      medidasControllers[medida] = controller;
    }

    if (editModel != null) {
      title = 'Editar medida ${editModel!.nome}';
      nomeController.text = editModel!.nome;
    }
  }

  void criarMedida() {
    TabelaDeMedidas tabela = TabelaDeMedidas({});
    for (final medida in MedidasPadrao.toList()) {
      if (medidasControllers[medida] != null && medidasControllers[medida]!.text.isNotEmpty) {
        tabela[medida] = double.parse(medidasControllers[medida]!.text);
      }
    }

    TabelaDeMedidasModel tabelaModel = TabelaDeMedidasModel(
      nome: nomeController.text,
      tabela: tabela,
      dataCriacao: DateTime.now(),
      ultimaModificacao: DateTime.now()
    );

    setState(() {
      medidaModels.add(tabelaModel);
    });
  }

  void salvarAlteracoes() {
    setState(() {
      medidaModels.remove(editModel);
      for (final String medida in listaDeMedidas) {
        if (medidasControllers[medida]!.text.isNotEmpty) {
          editModel!.tabela[medida] = double.parse(medidasControllers[medida]!.text);
        } else {
          editModel!.tabela.remove(medida);
        }
      }
      editModel!.nome = nomeController.text;
      editModel!.ultimaModificacao = DateTime.now();
      medidaModels.add(editModel!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: BackBar(
        title: title,
        context: context
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      controller: nomeController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insira um nome para a medida';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text('Nome da medida'),
                        fillColor: theme.colorScheme.surfaceContainerHighest,
                        filled: true,
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: theme.colorScheme.error
                          )
                        )
                      ),
                    )
                  )
                ),
                IconButton(
                  onPressed: () {
                    nomeController.text = '';
                  },
                  icon: Icon(Icons.cancel_outlined)
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('Medidas corporais', style: theme.textTheme.titleLarge)
            ),
            Expanded(
              child: ListView.separated(
                itemCount: listaDeMedidas.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 12);
                },
                itemBuilder: (context, index) {
                  final TextEditingController controller = medidasControllers[listaDeMedidas[index]]!;

                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: Text(listaDeMedidas[index]),
                            fillColor: theme.colorScheme.surfaceContainerHighest,
                            filled: true,
                          ),
                        )
                      ),
                      IconButton(
                        onPressed: () {
                          controller.text = '';
                        },
                        icon: Icon(Icons.cancel_outlined)
                      )
                    ]
                  );
                },
              )
            )
          ]
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Salvar',
        child: Icon(Icons.check),
        onPressed: () {
          bool valido = formKey.currentState!.validate();
          if (!valido) {
            return;
          }
          if (editModel != null) {
            salvarAlteracoes();
          } else {
            criarMedida();
          }
          Navigator.pop(context);
        }
      ),
    );
  }
}