import 'package:flutter/material.dart';

class ImportartMoldeFAB extends StatelessWidget {
  const ImportartMoldeFAB({super.key});

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
          onPressed: () {
            return;
          },
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          elevation: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.add, size: 23),
              Text('Importar molde', style: TextStyle(fontSize: 16))
            ],
          )
        )
      )
    );
  }
}