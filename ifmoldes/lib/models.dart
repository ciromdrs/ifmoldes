import 'package:ifmoldes/medidas.dart';

/// Model para TabelaDeMedidas.
class TabelaDeMedidasModel {
  String nome;
  final TabelaDeMedidas tabela;
  final DateTime dataCriacao;
  DateTime ultimaModificacao;

  TabelaDeMedidasModel({
    required this.nome,
    required this.tabela,
    required this.dataCriacao,
    required this.ultimaModificacao,
  });
}