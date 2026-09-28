import 'package:flutter/material.dart';

// WIDGET AUXILIAR (Caixa clicável com animação de encolher ao toque)
class AnimatedCategoryCard extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const AnimatedCategoryCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  State<AnimatedCategoryCard> createState() => _AnimatedCategoryCardState();
}

class _AnimatedCategoryCardState extends State<AnimatedCategoryCard> {
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
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(6.0),
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

              // Textos da categoria
              Padding(
                padding: EdgeInsets.only(left: 6.0, bottom: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 4.5, bottom: 4.5),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onPrimaryContainer,
                        )
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.5),
                      child: Text(
                        'Mais informações',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )
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