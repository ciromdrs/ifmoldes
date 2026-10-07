import 'package:flutter/material.dart';

/// AppBar customizada com botão de voltar.
///
/// Mantém o padrão visual do projeto e fornece automaticamente um botão de
/// voltar para a tela anterior.
class BackBar extends AppBar {
  /// Cria uma barra com título e botão de voltar.
  ///
  /// [title] é o texto exibido na área de título da AppBar.
  /// [context] é usado para fechar a tela atual com [Navigator.pop].
  BackBar({super.key, required String title, required BuildContext context})
      : super(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          centerTitle: false,
        );
}
