import 'package:flutter/material.dart';

// WIDGET AUXILIAR (Caixa clicável com animação de encolher ao toque)
class AnimatedPatternCard extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const AnimatedPatternCard({super.key, 
    required this.title,
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
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Área reservada para a imagem
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 6),

              // Textos do molde
              Padding(
                padding: EdgeInsets.only(left: 6.0, bottom: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 4.5, bottom: 4.5),
                      child: Text(
                        widget.title,
                        style: theme.textTheme.labelLarge
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.5),
                      child: Text(
                        'Mais informações',
                        style: theme.textTheme.labelSmall
                      )
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