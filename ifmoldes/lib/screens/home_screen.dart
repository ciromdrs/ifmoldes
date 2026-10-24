import 'package:flutter/material.dart';

import 'package:ifmoldes/components/drawer.dart';
import 'package:ifmoldes/components/pattern_card.dart';
import 'package:ifmoldes/data/medidas.dart';
import 'package:ifmoldes/data/moldes.dart';
import 'package:ifmoldes/models.dart';
import 'package:ifmoldes/molde.dart';
import 'package:ifmoldes/screens/medida_screen.dart';
import 'package:ifmoldes/screens/pattern_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // TODO: Adicionar moldes carregados do banco
    moldes = moldesExemplo;
    // Por padrão, começa na tela de moldes
    final conteudo = [
      conteudoTelaMoldes(context: context, moldes: List.from(moldes)),
      conteudoTelaMedidas(context: context, medidas: []),
    ][navbarIndex];

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      extendBody: true,
      // Menu Lateral de Hambúrguer
      drawer: MainDrawer(),
      // Barra Superior
      appBar: conteudo.appBar,
      // Corpo principal com rolagem ativada
      body: conteudo.body,
      // Barra Inferior
      bottomNavigationBar: _navbar(context, selectedIndex: navbarIndex),
      // Botão de ação flutuante (FAB)
      floatingActionButton: conteudo.fab,
    );
  }

  ({PreferredSizeWidget appBar, Widget body, StatelessWidget? fab})
  conteudoTelaMoldes({
    required BuildContext context,
    required List<Molde> moldes,
  }) {
    final GridMoldes gridMoldes = GridMoldes(moldes: moldes);
    return (appBar: appBarIFMoldes(context), body: gridMoldes, fab: null);
  }

  ({PreferredSizeWidget appBar, Widget body, StatelessWidget? fab})
  conteudoTelaMedidas({
    required BuildContext context,
    required List<TabelaDeMedidasModel> medidas,
  }) {
    return (
      appBar: appBarIFMoldes(context),
      body: TabelaDeMedidasModelListView(tabelas: []),
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

class GridMoldes extends StatefulWidget {
  const new({super.key, required this.moldes});

  final List<Molde> moldes;

  @override
  State<GridMoldes> createState() => _GridMoldesState();
}

class _GridMoldesState extends State<GridMoldes> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        itemCount: widget.moldes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final Molde molde = widget.moldes[index];
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
    );
  }

  void filterMoldes(String value) {
    setState(() {
      /*var moldes = moldesBase
          .where(
            (Molde molde) =>
                removeDiacritics(molde.modelo.toLowerCase())
                    .contains(removeDiacritics(value.toLowerCase())) ||
                removeDiacritics(molde.modelista.toLowerCase())
                    .contains(removeDiacritics(value.toLowerCase())),
          )
          .toList();*/
    });
  }
}

(PreferredSizeWidget, Widget, StatelessWidget?) conteudoTelaMedidas({
  required BuildContext context,
  required ValueChanged<String> searchBarOnChanged,
  required GlobalKey<ScaffoldState> scaffoldKey,
  required List<TabelaDeMedidasModel> medidas_,
}) {
  // medidas = medidas_;
  return (
    appBarIFMoldes(context),

    TabelaDeMedidasModelListView(tabelas: [] /* medidas */),
    FloatingActionButton(
      tooltip: 'Registrar medida',
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MedidaScreen(medidaModels: []),
          ),
        );
      },
    ),
  );
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

PreferredSizeWidget appBarIFMoldes(BuildContext context) {
  return AppBar(title: appTitleWidget, automaticallyImplyLeading: true);
}

class TabelaDeMedidasModelListView extends StatelessWidget {
  final List<TabelaDeMedidasModel> tabelas;

  const new({super.key, required this.tabelas});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView(
            children: tabelaModelsExemplo
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
