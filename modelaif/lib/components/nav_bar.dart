import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    const double iconsSize = 38;

    return UnconstrainedBox(
      child: Container(
        width: mediaQuery.size.width * .48,
        height: 76,
        margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(48),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(160, 12, 12, 12),
              offset: Offset(0, 3),
              blurRadius: 5
            )
          ]
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: Colors.transparent,
          elevation: 4,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.checkroom_outlined, size: iconsSize),
              selectedIcon: Icon(Icons.checkroom, size: iconsSize),
              label: 'Moldes',
            ),
            NavigationDestination(
              icon: Icon(Icons.design_services_outlined, size: iconsSize),
              selectedIcon: Icon(Icons.design_services, size: iconsSize),
              label: 'Medidas',
            ),
          ]
        )
      ),
    );
  }
}