import 'package:flutter/material.dart';

import 'package:ifmoldes/components/back_bar.dart';
import 'package:ifmoldes/models.dart';
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
      title = 'Editar medida';
      nomeController.text = editModel!.nome;
    }
  }

  void criarMedida() {
    TabelaDeMedidas tabela = TabelaDeMedidas({});
    for (final medida in MedidasPadrao.toList()) {
      if (medidasControllers[medida] != null &&
          medidasControllers[medida]!.text.isNotEmpty) {
        tabela[medida] = double.parse(medidasControllers[medida]!.text);
      }
    }

    TabelaDeMedidasModel tabelaModel = TabelaDeMedidasModel(
      nome: nomeController.text,
      tabela: tabela,
      dataCriacao: DateTime.now(),
      ultimaModificacao: DateTime.now(),
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
          editModel!.tabela[medida] = double.parse(
            medidasControllers[medida]!.text,
          );
        } else {
          editModel!.tabela.remove(medida);
        }
      }
      editModel!.nome = nomeController.text.trim();
      editModel!.ultimaModificacao = DateTime.now();
      medidaModels.add(editModel!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: BackBar(title: title, context: context),

      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: 16) + EdgeInsets.only(bottom: 16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nomeController,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Insira um nome para a medida';
                  }
                  return null;
                },
                style: theme.textTheme.headlineMedium,
                /*
                TODO: Descomentar quando implementar o suffixIcon que desaparece.
                onChanged: (value) {
                  // Necessário redesenhar o componente para o suffixIcon aparecer
                  setState(() {});
                },*/
                decoration: InputDecoration(
                  label: Text('Nome'),
                  filled: false,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.colorScheme.error),
                  ),
                  suffixIcon:
                      /* TODO: Descomentar quando implementar o suffixIcon que desaparece.
                      nomeController.text.isEmpty
                      ? SizedBox.fromSize(size: Size(1, 1))
                      : */
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          nomeController.text = '';
                          /* TODO: Descomentar quando implementar o suffixIcon que desaparece.
                          setState(() {
                            nomeController.text = '';
                          });*/
                        },
                      ),
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: MedidasPadrao.toList().map((m) {
                  final TextEditingController controller =
                      medidasControllers[m]!;

                  return Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: TextFormField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text(m),
                        fillColor: theme.colorScheme.surfaceContainerHighest,
                        filled: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.text = '';
                          },
                          icon: Icon(Icons.close),
                        ),
                        suffixText: 'cm',
                      ),
                      validator: (value) => double.tryParse(value ?? '') != null
                          ? null
                          : 'Insira uma medida válida. Ex.: 26.5',
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
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
        },
      ),
    );
  }
}
