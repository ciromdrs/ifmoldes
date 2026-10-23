import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';

import 'package:ifmoldes/components/main_header.dart';
import 'package:ifmoldes/components/drawer.dart';
import 'package:ifmoldes/components/nav_bar.dart';
import 'package:ifmoldes/components/fab_flutuante.dart';
import 'package:ifmoldes/models.dart';
import 'package:ifmoldes/screens/medida_screen.dart';

import 'package:ifmoldes/data/medidas.dart';

class MedidasScreen extends StatefulWidget {
  final List<TabelaDeMedidasModel> medidaModels;

  const MedidasScreen({super.key, required this.medidaModels});

  @override
  State<MedidasScreen> createState() => MedidasScreenState();
}

class MedidasScreenState extends State<MedidasScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchController = TextEditingController();
  late List<TabelaDeMedidasModel> medidasBase;
  late List<TabelaDeMedidasModel> filteredMedidas;
  late List<TabelaDeMedidasModel> medidaModels;

  @override
  initState() {
    super.initState();
    medidasBase = tabelaModelsExemplo;
    filteredMedidas = List.from(medidasBase);
    medidaModels = widget.medidaModels;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,

      drawer: MainDrawer(),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      
      bottomNavigationBar: Navbar(selectedIndex: 1,),
    );
  }
}