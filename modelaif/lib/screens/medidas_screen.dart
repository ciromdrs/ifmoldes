import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';

import 'package:modelaif/components/main_header.dart';
import 'package:modelaif/medidas.dart';
import 'package:modelaif/components/nav_bar.dart';
import 'package:modelaif/models.dart';

class MedidasScreen extends StatefulWidget {
  const MedidasScreen({super.key});

  @override
  State<MedidasScreen> createState() => MedidasScreenState();
}

class MedidasScreenState extends State<MedidasScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchController = TextEditingController();
  late List<TabelaDeMedidasModel> medidasBase;
  late List<TabelaDeMedidasModel> filteredMedidas;

  @override
  initState() {
    super.initState();
    medidasBase = medidasExemplo;
    filteredMedidas = List.from(medidasBase);
  }

  void filterMedidas(String value) {
    setState(() {
      filteredMedidas = medidasBase
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
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: HomeHeader(
        scaffoldKey: _scaffoldKey,
        searchController: searchController,
        searchBarOnChanged: filterMedidas,
        searchPlaceholder: 'Buscar medidas'
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: filteredMedidas.length,
              itemBuilder: (context, index) {
                final TabelaDeMedidasModel medidas = filteredMedidas[index];
                return Container(
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
                                medidas.dataCriacao.toString(),
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
                    ],
                  )
                  ) 
                );
              }
            )
          )
        ]
      ),
      
      bottomNavigationBar: Navbar(selectedIndex: 1,),
    );
  }
}