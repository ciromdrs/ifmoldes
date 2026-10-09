import 'package:flutter/material.dart';

import 'package:ifmoldes/components/back_bar.dart';
import 'package:ifmoldes/medidas.dart';

class MedidaScreen extends StatefulWidget {
  const MedidaScreen({super.key});

  @override
  State<MedidaScreen> createState() => _MedidaScreenState();
}

class _MedidaScreenState extends State<MedidaScreen> {
  final TextEditingController nomeController = TextEditingController();
  final List<String> listaDeMedidas = MedidasPadrao.toList();
  final Map<String, TextEditingController> medidasControllers = {};

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: BackBar(
        title: 'Criar nova medida',
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
                  child: TextFormField(
                    controller: nomeController,
                    decoration: InputDecoration(
                      label: Text('Nome da medida'),
                      fillColor: theme.colorScheme.surfaceContainerHighest,
                      filled: true
                    ),
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
                  final TextEditingController controller = TextEditingController();
                  medidasControllers[listaDeMedidas[index]] = controller;
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
      )
    );
  }
}