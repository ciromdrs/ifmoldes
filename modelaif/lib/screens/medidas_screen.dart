import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';

import 'package:modelaif/components/main_header.dart';
import 'package:modelaif/medidas.dart';

class MedidasScreen extends StatefulWidget {
  const MedidasScreen({super.key});

  @override
  State<MedidasScreen> createState() => MedidasScreenState();
}

class MedidasScreenState extends State<MedidasScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchController = TextEditingController();
  late List<TabelaDeMedidas> medidasBase;
  late List<TabelaDeMedidas> filteredMedidas;

  @override
  initState() {
    super.initState();
    medidasBase = [];
    filteredMedidas = List.from(medidasBase);
  }

  void filterMedidas(String value) {
    setState(() {
      filteredMedidas = medidasBase
          .where(
            (TabelaDeMedidas medidas) =>
                removeDiacritics(medidas['nome'].toLowerCase())
                    .contains(removeDiacritics(value.toLowerCase())),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: HomeHeader(
        scaffoldKey: _scaffoldKey,
        searchController: searchController,
        searchBarOnChanged: filterMedidas,
        searchPlaceholder: 'Buscar medidas'
      ),
    );
  }
}