import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';
import 'package:ifmoldes/components/main_header.dart';
import 'package:ifmoldes/molde.dart';
import 'package:ifmoldes/screens/pattern_screen.dart';
import 'package:ifmoldes/components/pattern_card.dart';
import 'package:ifmoldes/components/nav_bar.dart';
import 'package:ifmoldes/components/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controle de estado e navegação
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController searchController = TextEditingController();

  late List<Molde> moldesBase;
  late List<Molde> filteredMoldes;

  @override
  initState() {
    super.initState();
    searchController = searchController;
    moldesBase = moldesExemplo;
    filteredMoldes = List.from(moldesBase);
  }

  void filterMoldes(String value) {
    setState(() {
      filteredMoldes = moldesBase
          .where(
            (Molde molde) =>
                removeDiacritics(molde.modelo.toLowerCase())
                    .contains(removeDiacritics(value.toLowerCase())),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: theme.colorScheme.surface,
      extendBody: true,

      // DRAWER (Menu Lateral de Hambúrguer)
      drawer: MainDrawer(),

      // APP BAR (Barra Superior Fixa)
      appBar: HomeHeader(
        searchBarOnChanged: filterMoldes,
        scaffoldKey: _scaffoldKey,
        searchController: searchController,
      ) as PreferredSizeWidget,

      // BODY (Corpo principal com rolagem ativada)
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: GridView.builder(
          itemCount: filteredMoldes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final Molde molde = filteredMoldes[index];
            return AnimatedPatternCard(
              molde: molde,
              onTap: () {
                // Navegação para a PatternScreen passando o nome da categoria
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatternScreen(molde)),
                );
              },
            );
          },
        ),
      ),

      // Botão de ação flutuante (FAB)
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: ImportartMoldeFAB(),

      // TODO: Descomentar quando a página de medidas for implementada.
      // BOTTOM NAVIGATION BAR (Barra Inferior Fixa)
      bottomNavigationBar: Navbar(),
    );
  }
}
