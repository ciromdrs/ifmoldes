import 'package:flutter/material.dart';

class HomeHeader extends AppBar {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final TextEditingController searchController;
  final void Function(String)? searchBarOnChanged;

  HomeHeader({
    super.key,
    required this.scaffoldKey,
    required this.searchController,
    required this.searchBarOnChanged
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  late void Function(String)? searchBarOnChanged;

  @override
  initState() {
    super.initState();
    searchBarOnChanged = widget.searchBarOnChanged;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PreferredSize(
      preferredSize: const Size.fromHeight(64.0),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            children: [
              // Botão de Menu Hambúrguer
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  widget.scaffoldKey.currentState?.openDrawer();
                },
              ),
              const SizedBox(width: 4),

              // Campo de Busca centralizado
              Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: searchBarOnChanged,
                          decoration: InputDecoration(
                            hintText: 'Buscar molde',
                            hintStyle: TextStyle(
                              fontSize: 15,
                            ),
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
              const SizedBox(width: 4),

              // Botão de Filtro
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}