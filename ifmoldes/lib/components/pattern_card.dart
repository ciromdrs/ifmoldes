import 'package:flutter/material.dart';
import 'package:ifmoldes/molde.dart';

// WIDGET AUXILIAR (Caixa clicável com animação de encolher ao toque)
class AnimatedPatternCard extends StatefulWidget {
  /// Nome do molde.
  final Molde molde;

  /// Função executada ao clicar no card.
  final VoidCallback onTap;

  const AnimatedPatternCard({super.key, 
    required this.molde,
    required this.onTap,
  });

  @override
  State<AnimatedPatternCard> createState() => _AnimatedPatternCardState();
}

class _AnimatedPatternCardState extends State<AnimatedPatternCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0, // Encolhe levemente ao pressionar
        duration: Duration(milliseconds: 100),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer,
            border: Border.all(color: theme.colorScheme.outlineVariant, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Área reservada para a imagem
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child:
                    /// TODO: Trocar para ImageProvider quando houver moldes importados de arquivos externos.
                    /// BUG: No Linux e Android, carrega infinitamente e não abre.
                    /// No Android, abre na segunda tentativa.
                    /// No Chrome, abre normalmente.
                    Image.asset(widget.molde.imagem, width: double.infinity),
                ),
              ),

              // Textos do molde
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.molde.modelo,
                      style: theme.textTheme.labelLarge
                    ),
                    Text(
                      'por ${widget.molde.modelista}',
                      style: theme.textTheme.labelSmall
                    )
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}