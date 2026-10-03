import 'package:modelaif/medidas.dart';

/// Model para TabelaDeMedidas.
class TabelaDeMedidasModel {
  final String nome;
  final TabelaDeMedidas tabela;
  final DateTime dataCriacao;
  final DateTime ultimaModificacao;

  const TabelaDeMedidasModel({
    required this.nome,
    required this.tabela,
    required this.dataCriacao,
    required this.ultimaModificacao,
  });
}
