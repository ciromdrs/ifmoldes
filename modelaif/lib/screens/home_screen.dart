import 'package:flutter/material.dart';
import '../components/nav_bar.dart';
import '../components/home_header.dart';
import '../components/fab_importar.dart';
import '../components/cards_padding.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controle de estado e navegação
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: theme.colorScheme.surface,
      extendBody: true,

      // DRAWER (Menu Lateral de Hambúrguer)
      drawer: const Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        ),
      ),

      // APP BAR (Barra Superior Fixa)
      appBar: HomeHeader(scaffoldKey: _scaffoldKey) as PreferredSizeWidget,

      // BODY (Corpo principal com rolagem ativada)
      body: CardsPadding(),

      // Botão de ação flutuante (FAB)
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ImportartMoldeFAB(),

      // BOTTOM NAVIGATION BAR (Barra Inferior Fixa)
      bottomNavigationBar: Navbar(),
    );
  }
}
