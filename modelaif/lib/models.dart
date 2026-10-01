import 'package:modelaif/medidas.dart';

/// Model para TabelaDeMedidas.
class TabelaDeMedidasModel {
  final Map<String, dynamic> tabela;
  final DateTime dataCriacao;
  final DateTime ultimaModificacao;

  const TabelaDeMedidasModel({
    required this.tabela,
    required this.dataCriacao,
    required this.ultimaModificacao,
  });
}
