import 'package:flutter/material.dart';
import 'package:ifmoldes/models.dart';

class HomeHeader extends AppBar {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final TextEditingController searchController;
  final void Function(String)? searchBarOnChanged;
  final String searchPlaceholder;
  final List<TabelaDeMedidasModel>? medidaModels;
  final ValueChanged<List<TabelaDeMedidasModel>>? onFilter;

  HomeHeader({
    super.key,
    required this.scaffoldKey,
    required this.searchController,
    required this.searchBarOnChanged,
    this.searchPlaceholder = 'Buscar molde',
    this.medidaModels,
    this.onFilter
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  late void Function(String)? searchBarOnChanged;
  late String searchPlaceholder;
  late List<TabelaDeMedidasModel>? medidaModels;
  late ValueChanged<List<TabelaDeMedidasModel>>? onFilter;

  @override
  initState() {
    super.initState();
    searchBarOnChanged = widget.searchBarOnChanged;
    searchPlaceholder = widget.searchPlaceholder;
    medidaModels = widget.medidaModels;
    onFilter = widget.onFilter;
  }

  @override
  void didUpdateWidget(HomeHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.medidaModels != oldWidget.medidaModels) {
      setState(() {
        medidaModels = widget.medidaModels;
      });
    }
  }

  int filterNovas(TabelaDeMedidasModel a, TabelaDeMedidasModel b) {
    return a.dataCriacao.compareTo(b.dataCriacao);
  }

  int filterAntigas(TabelaDeMedidasModel a, TabelaDeMedidasModel b) {
    return b.dataCriacao.compareTo(a.dataCriacao);
  }

  int filterModificadasRecentemente(TabelaDeMedidasModel a, TabelaDeMedidasModel b) {
    return a.ultimaModificacao.compareTo(b.ultimaModificacao);
  }

  int filterOrdemAlfabetica(TabelaDeMedidasModel a, TabelaDeMedidasModel b) {
    return a.nome.compareTo(b.nome);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const gap = SizedBox(width: 4);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
        child: Row(
          children: [
            // Botão de Menu Hambúrguer
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                widget.scaffoldKey.currentState?.openDrawer();
              },
            ),
            gap,

            // Campo de Busca centralizado
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(22),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: searchBarOnChanged,
                        decoration: InputDecoration(
                          hintText: searchPlaceholder,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ),
            gap,

            // TODO: Descomentar quando o filtro for implementado.
            // Botão de Filtro
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  scrollControlDisabledMaxHeightRatio: .34,
                  builder: (BuildContext modalContext) {
                    return Padding(
                      padding: EdgeInsets.only(top: 6.0, left: 10.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('Mais novas'),
                            onTap: () {
                              // setState(() {
                                medidaModels!.sort(filterNovas);
                              // });
                              onFilter!(medidaModels!);
                              Navigator.of(modalContext).pop();
                            },
                          ),
                          ListTile(
                            title: Text('Mais antigas'),
                            onTap: () {
                              setState(() {
                                medidaModels!.sort(filterAntigas);
                              });
                              onFilter!(medidaModels!);
                              Navigator.pop(modalContext);
                            },
                          ),
                          ListTile(
                            title: Text('Ordem alfabética'),
                            onTap: () {
                              setState(() {
                                medidaModels!.sort(filterOrdemAlfabetica);
                              });
                              onFilter!(medidaModels!);
                              Navigator.pop(modalContext);
                            },
                          ),
                          ListTile(
                            title: Text('Modificadas recentemente'),
                            onTap: () {
                              setState(() {
                                medidaModels!.sort(filterModificadasRecentemente);
                              });
                              onFilter!(medidaModels!);
                              Navigator.pop(modalContext);
                            },
                          ),
                        ],
                      )
                    );
                  }
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}