import 'package:flutter/material.dart';

import 'package:ifmoldes/components/drawer.dart';
import 'package:ifmoldes/components/pattern_card.dart';
import 'package:ifmoldes/components/fab_flutuante.dart';
import 'package:ifmoldes/data/medidas.dart';
import 'package:ifmoldes/data/moldes.dart';
import 'package:ifmoldes/models.dart';
import 'package:ifmoldes/molde.dart';
import 'package:ifmoldes/screens/medida_screen.dart';
import 'package:ifmoldes/screens/pattern_screen.dart';
import 'package:ifmoldes/models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controle de estado e navegação
  int navbarIndex = 0;
  late List<Molde> moldes;

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

      // DRAWER (Menu Lateral de Hambúrguer)
      drawer: MainDrawer(),

      // APP BAR (Barra Superior Fixa)
      appBar: conteudo.appBar,

      // BODY (Corpo principal com rolagem ativada)
      body: conteudo.body,

      // Botão de ação flutuante (FAB)
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FABFlutuante(texto: 'Importar molde', iconData: Icons.add, callback: () {}),

      // BOTTOM NAVIGATION BAR (Barra Inferior Fixa)
      bottomNavigationBar: _navbar(context, selectedIndex: navbarIndex),
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
      body: ListaDeTabelasDeMedidas(),
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

class ListaDeTabelasDeMedidas extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: tabelaModelsExemplo.length,
            itemBuilder: (context, index) {
              final theme = Theme.of(context);
              final TabelaDeMedidasModel medidas = tabelaModelsExemplo[index];
              const List<String> meses = [
                'janeiro',
                'fevereiro',
                'março',
                'abril',
                'maio',
                'junho',
                'julho',
                'agosto',
                'setembro',
                'outubro',
                'novembro',
                'dezembro',
              ];
              String hora = medidas.ultimaModificacao.hour.toString();
              if (hora.length == 1) {
                hora = '0$hora';
              }
              String minuto = medidas.ultimaModificacao.minute.toString();
              if (minuto.length == 1) {
                minuto = '0$minuto';
              }
              String segundo = medidas.ultimaModificacao.second.toString();
              if (segundo.length == 1) {
                segundo = '0$segundo';
              }
              final String textoUltimaModificacao =
                  '''${medidas.ultimaModificacao.day} de ${meses[medidas.ultimaModificacao.month - 1]} de ${medidas.ultimaModificacao.year} às $hora:$minuto:$segundo''';

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MedidaScreen(medidaModels: [], editModel: medidas),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left: 28.0, right: 28.0),
                  decoration: BoxDecoration(
                    border: BoxBorder.fromLTRB(
                      bottom: BorderSide(
                        color: theme.colorScheme.outlineVariant,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 11.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          spacing: 8.0,
                          children: [
                            Icon(
                              Icons.design_services_outlined,
                              size: 22,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: .6,
                              children: [
                                Text(
                                  medidas.nome,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                Text(
                                  textoUltimaModificacao,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.file_upload_outlined,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  
  (PreferredSizeWidget, Widget, StatelessWidget?) conteudoTelaMedidas({
    required BuildContext context,
    required ValueChanged<String> searchBarOnChanged,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required List<TabelaDeMedidasModel> medidas_
  }) {
    medidas = medidas_;
    return (
      HomeHeader(
        scaffoldKey: _scaffoldKey,
        searchController: searchController,
        searchBarOnChanged: filterMedidas,
        searchPlaceholder: 'Buscar medidas',
        medidaModels: medidas,
        onFilter: (value) {
          setState(() {
            medidas = value;
          });
        }
      ),
      listaMedidas(context, medidas),
      FABFlutuante(
        texto: 'Registrar medida',
        iconData: Icons.add,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MedidaScreen(medidaModels: medidas,)
            )
          );
        }
      ),
    );
  }

  Widget listaMedidas(
    BuildContext context,
    List<TabelaDeMedidasModel> filteredMedidas
  ) {
    final ThemeData theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: medidas.length,
            itemBuilder: (context, index) {
              final TabelaDeMedidasModel medidas = filteredMedidas[index];
              const List<String> meses = [
                'janeiro',
                'fevereiro',
                'março',
                'abril',
                'maio',
                'junho',
                'julho',
                'agosto',
                'setembro',
                'outubro',
                'novembro',
                'dezembro',
              ];
              String hora = medidas.ultimaModificacao.hour.toString();
              if (hora.length == 1) {
                hora = '0$hora';
              }
              String minuto = medidas.ultimaModificacao.minute.toString();
              if (minuto.length == 1) {
                minuto = '0$minuto';
              }
              String segundo = medidas.ultimaModificacao.second.toString();
              if (segundo.length == 1) {
                segundo = '0$segundo';
              }
              final String textoUltimaModificacao = '''${medidas.ultimaModificacao.day} de ${meses[medidas.ultimaModificacao.month - 1]} de ${medidas.ultimaModificacao.year} às $hora:$minuto:$segundo''';

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedidaScreen(medidaModels: medidasBase, editModel: medidas,),
                    )
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left: 28.0, right: 28.0),
                  decoration: BoxDecoration(
                    border: BoxBorder.fromLTRB(bottom: BorderSide(color: theme.colorScheme.outlineVariant))
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 11.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          spacing: 8.0,
                          children: [
                            Icon(Icons.design_services_outlined, size: 22, color: theme.colorScheme.onSurfaceVariant,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: .6,
                              children: [
                                Text(
                                  medidas.nome,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: theme.colorScheme.onSurface
                                  )
                                ),
                                Text(
                                  textoUltimaModificacao,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: theme.colorScheme.onSurfaceVariant
                                  )
                                ),
                              ]
                            )
                          ],
                        ),
                        Icon(Icons.file_upload_outlined, color: theme.colorScheme.onSurfaceVariant)
                      ]
                    ),
                  )
                )
              );
            }
          )
        )
      ]
    );
  }
}

PreferredSizeWidget appBarIFMoldes(BuildContext context) {
  return AppBar(
    title: Row(
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
    ),
    automaticallyImplyLeading: true,
  );
}
