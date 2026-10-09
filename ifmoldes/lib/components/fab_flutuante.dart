import 'package:flutter/material.dart';

class FABFlutuante extends StatelessWidget {
  final String texto;
  final IconData iconData;
  final VoidCallback onPressed;

  const FABFlutuante({super.key, required this.texto, required this.iconData, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 28),
      child: SizedBox(
        width: mediaQuery.size.width * .45,
        height: 60,
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          elevation: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(iconData, size: 23),
              Text(texto, style: TextStyle(fontSize: 16))
            ],
          )
        )
      )
    );
  }
}