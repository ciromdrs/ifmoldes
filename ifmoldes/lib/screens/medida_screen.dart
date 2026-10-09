import 'package:flutter/material.dart';

import 'package:ifmoldes/components/back_bar.dart';

class MedidaScreen extends StatefulWidget {
  const MedidaScreen({super.key});

  @override
  State<MedidaScreen> createState() => _MedidaScreenState();
}

class _MedidaScreenState extends State<MedidaScreen> {
  final TextEditingController nomeController = TextEditingController();

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
          )
        ]),
      )
    );
  }
}