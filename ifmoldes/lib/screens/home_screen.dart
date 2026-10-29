import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';

import 'package:ifmoldes/components/pattern_card.dart';
import 'package:ifmoldes/data/medidas.dart';
import 'package:ifmoldes/data/moldes.dart';
import 'package:ifmoldes/models.dart';
import 'package:ifmoldes/molde.dart';
import 'package:ifmoldes/screens/medida_screen.dart';
import 'package:ifmoldes/screens/pattern_screen.dart';
import 'package:ifmoldes/screens/sobre_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controle de estado e navegação
  int navbarIndex = 0;
  late List<Molde> moldes;
  late List<TabelaDeMedidasModel> medidas;
  String searchBarQuery = '';

  @override
  Widget build(BuildContext context) {
    const toolbarBaseHeight = 56.0;
    const toolbarBottomPadding = 8.0;
    final theme = Theme.of(context);

    // TODO: Adicionar moldes carregados do banco
    moldes = moldesExemplo;

    // TODO: Adicionar medidas carregadas do banco
    medidas = tabelaModelsExemplo;


    final conteudo = [
      conteudoTelaMoldes(context: context),
      conteudoTelaMedidas(context: context),
    ][navbarIndex];

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      extendBody: true,
      // Barra Superior
      appBar: AppBar(
        title: Text('IF Moldes'),
        automaticallyImplyLeading: false,
        automaticallyImplyActions: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SobreScreen()),
              );
            },
            icon: Icon(Icons.question_mark),
            tooltip: 'Sobre',
          ),
        ],
        bottom: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            // Empurra a barra de busca um pouco para cima
            padding: const EdgeInsets.only(bottom: toolbarBottomPadding),
            child: SearchBar(
              autoFocus: true,
              shadowColor: WidgetStatePropertyAll(Colors.transparent),
              onChanged: (newQuery) {
                setState(() {
                  searchBarQuery = newQuery;
                });
              },
              hintText: 'Buscar',
            ),
          ),
          toolbarHeight: toolbarBaseHeight + toolbarBottomPadding,
        ),
      ),
      // Corpo principal com rolagem ativada
      body: conteudo.body,
      // Barra Inferior
      bottomNavigationBar: _navbar(context, selectedIndex: navbarIndex),
      // Botão de ação flutuante (FAB)
      floatingActionButton: conteudo.fab,
    );
  }

  ({Widget body, StatelessWidget? fab}) conteudoTelaMoldes({
    required BuildContext context,
  }) {
    final GridMoldes gridMoldes = GridMoldes(
      moldes: moldes,
      query: searchBarQuery,
    );
    return (body: gridMoldes, fab: null);
  }

  ({Widget body, StatelessWidget? fab}) conteudoTelaMedidas({
    required BuildContext context,
  }) {
    return (
      body: TabelaDeMedidasModelListView(
        tabelas: tabelaModelsExemplo,
        query: searchBarQuery,
      ),
      fab: FloatingActionButton(
        tooltip: 'Registrar medida',
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MedidaScreen(medidaModels: medidas),
            ),
          );
        },
      ),
    );
  }

  NavigationBar _navbar(BuildContext context, {required int selectedIndex}) {
    return NavigationBar(
      maintainBottomViewPadding: true,
      selectedIndex: selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          navbarIndex = index;
        });
      },
      elevation: 1,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.checkroom_outlined),
          selectedIcon: Icon(Icons.checkroom_sharp),
          label: 'Moldes',
        ),
        NavigationDestination(
          icon: Icon(Icons.design_services_outlined),
          selectedIcon: Icon(Icons.design_services_sharp),
          label: 'Medidas',
        ),
      ],
    );
  }
}

class GridMoldes extends StatelessWidget {
  final List<Molde> moldes;
  final String query;

  const new({super.key, required this.moldes, required this.query});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.extent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: .8,
        children: moldes
            .where(
              (Molde molde) =>
                  removeDiacritics(molde.modelo.toLowerCase())
                      .contains(removeDiacritics(query.toLowerCase())),
            )
            .map(
              (e) => AnimatedPatternCard(
                molde: e,
                onTap: () {
                  // Navegação para a PatternScreen passando o nome da categoria
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PatternScreen(e)),
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

const appTitleWidget = Row(
  children: [
    Baseline(
      // Este baseline compensa a diferença de altura entre as fontes
      baseline: 20,
      baselineType: TextBaseline.alphabetic,
      child: Text(
        'IF',
        style: TextStyle(
          color: Color.fromARGB(255, 101, 101, 101),
          fontWeight: FontWeight.w600,
          fontFamily: 'Open Sans',
        ),
      ),
    ),
    Text(
      'Moldes',
      style: TextStyle(
        color: Color.fromARGB(255, 50, 160, 65),
        fontWeight: FontWeight.bold,
        fontFamily: 'Outfit',
      ),
    ),
  ],
);

class TabelaDeMedidasModelListView extends StatelessWidget {
  final List<TabelaDeMedidasModel> tabelas;
  final String query;

  const new({super.key, required this.tabelas, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView(
            children: tabelaModelsExemplo
                .where(
                  (TabelaDeMedidasModel t) =>
                      removeDiacritics(t.nome.toLowerCase())
                          .contains(removeDiacritics(query.toLowerCase())),
                )
                .map(
                  (t) => ListTile(
                    title: Text(t.nome),
                    leading: Icon(Icons.design_services_outlined),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MedidaScreen(
                            medidaModels: [] /*medidasBase*/,
                            editModel: t,
                          ),
                        ),
                      );
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
