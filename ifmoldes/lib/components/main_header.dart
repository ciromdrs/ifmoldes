import 'package:flutter/material.dart';

class HomeHeader extends AppBar {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final TextEditingController searchController;
  final void Function(String)? searchBarOnChanged;
  final String searchPlaceholder;

  HomeHeader({
    super.key,
    required this.scaffoldKey,
    required this.searchController,
    required this.searchBarOnChanged,
    this.searchPlaceholder = 'Buscar molde'
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  late void Function(String)? searchBarOnChanged;
  late String searchPlaceholder;

  @override
  initState() {
    super.initState();
    searchBarOnChanged = widget.searchBarOnChanged;
    searchPlaceholder = widget.searchPlaceholder;
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
            /*IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {},
            ),*/
          ],
        ),
      ),
    );
  }
}