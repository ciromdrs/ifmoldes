import 'package:flutter/material.dart';
import 'package:ifmoldes/components/form_medidas.dart';

import 'package:ifmoldes/components/back_bar.dart';
import 'package:ifmoldes/components/parte_molde.dart';

import 'package:ifmoldes/molde.dart';

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