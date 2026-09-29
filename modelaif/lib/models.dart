import 'medidas.dart';

/// Model para TabelaDeMedidas.
class TabelaDeMedidasModel {
  final TabelaDeMedidas tabela;
  final DateTime dataCriacao;
  final DateTime ultimaModificacao;

  const TabelaDeMedidasModel({
    required this.tabela,
    required this.dataCriacao,
    required this.ultimaModificacao,
  });
}
