import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';

import 'package:ifmoldes/components/drawer.dart';
import 'package:ifmoldes/components/main_header.dart';
import 'package:ifmoldes/components/pattern_card.dart';
import 'package:ifmoldes/components/fab_flutuante.dart';
import 'package:ifmoldes/data/medidas.dart';
import 'package:ifmoldes/data/moldes.dart';
import 'package:ifmoldes/molde.dart';
import 'package:ifmoldes/screens/medidas_screen.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController searchController = TextEditingController();
  int navbarIndex = 0;
  late List<Molde> moldes;
  late List<Molde> moldesBase;
  late List<TabelaDeMedidasModel> medidasBase;
  late List<TabelaDeMedidasModel> medidas;
  late PreferredSizeWidget appBar;
  late Widget body;
  late StatelessWidget? fab;

  @override
  initState() {
    super.initState();
    searchController = searchController;
    // TODO: Adicionar moldes carregados do banco
    moldesBase = moldesExemplo;
    medidasBase = tabelaModelsExemplo;
    // Só variáveis locais podem ser usadas em pattern assignments no Dart,
    // então precisamos usar as auxiliares abaixo
    // Por padrão, começa na tela de moldes
    final (appBar_, body_, fab_) = conteudoTelaMoldes(
      searchBarOnChanged: filterMoldes,
      scaffoldKey: _scaffoldKey,
      searchController: searchController,
      moldes: List.from(moldesBase),
    );
    // Repassa o valor das auxiliares para as propriedades da classe
    appBar = appBar_;
    body = body_;
    fab = fab_;
  }

  void filterMoldes(String value) {
    setState(() {
      moldes = moldesBase
          .where(
            (Molde molde) =>
                removeDiacritics(molde.modelo.toLowerCase())
                    .contains(removeDiacritics(value.toLowerCase())) ||
                removeDiacritics(molde.modelista.toLowerCase())
                    .contains(removeDiacritics(value.toLowerCase())),
          )
          .toList();
    });
  }

  void filterMedidas(String value) {
    setState(() {
      medidas = medidasBase
          .where(
            (TabelaDeMedidasModel medidas) =>
                removeDiacritics(medidas.nome.toLowerCase())
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
      appBar: appBar,

      // BODY (Corpo principal com rolagem ativada)
      body: body,

      // Botão de ação flutuante (FAB)
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FABFlutuante(texto: 'Importar molde', iconData: Icons.add, callback: () {}),

      // BOTTOM NAVIGATION BAR (Barra Inferior Fixa)
      bottomNavigationBar: _navbar(
        context,
        selectedIndex: navbarIndex,
        onDestinationSelected: (int index) {
          navbarIndex = index;
          final PreferredSizeWidget appBar_;
          final Widget body_;
          final StatelessWidget? fab_;

          final Widget screen = [
            HomeScreen(),
            MedidasScreen(medidaModels: tabelaModelsExemplo),
          ][index];
          if (navbarIndex == 0) {
            (appBar_, body_, fab_) = conteudoTelaMoldes(
              searchBarOnChanged: filterMoldes,
              scaffoldKey: _scaffoldKey,
              searchController: searchController,
              moldes: List.from(moldesBase),
            );
            setState(() {
              appBar = appBar_;
              body = body_;
              fab = fab_;
            });
          }
          else if (navbarIndex == 1) {
            (appBar_, body_, fab_) = conteudoTelaMedidas(
              context: context,
              searchBarOnChanged: filterMedidas,
              scaffoldKey: _scaffoldKey,
              medidas_: List.from(medidasBase)
            );
            setState(() {
              appBar = appBar_;
              body = body_;
              fab = fab_;
            });
          }
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => screen),
          // );
        },
      ),
      floatingActionButton: fab,
    );
  }

  (PreferredSizeWidget, Widget, StatelessWidget?) conteudoTelaMoldes({
    required ValueChanged<String> searchBarOnChanged,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required TextEditingController searchController,
    required List<Molde> moldes,
  }) {
    return (
      HomeHeader(
        searchBarOnChanged: searchBarOnChanged,
        scaffoldKey: scaffoldKey,
        searchController: searchController,
      ) as PreferredSizeWidget,
      gridMoldes(moldes),
      null,
    );
  }

  Widget gridMoldes(List<Molde> moldes) {
    List<Molde> filteredMoldes = moldes;
    return Padding(
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
    );
  }

  NavigationBar _navbar(
    BuildContext context, {
    required int selectedIndex,
    required Function(int) onDestinationSelected,
  }) {
    return NavigationBar(
      maintainBottomViewPadding: true,
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
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
