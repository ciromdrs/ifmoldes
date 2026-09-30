/// Tabela de medidas de uma pessoa.
/// TODO: Transformar em extension de Map<String, double>?
class TabelaDeMedidas {
  /// Nome da tabela. Ex.: "Alice", "Padrão M", etc.
  final String nome;

  /// Map de medida para valor em cm.
  final Map<String, double> map;

  const TabelaDeMedidas({
    this.nome = 'Sem nome',
    this.map = const {},
  });

  /// Retorna [map] como uma lista ordenada.
  List<MapEntry<String, double>> toList() {
    List<MapEntry<String, double>> ordenada = map.entries.toList();
    ordenada.sort((a, b) => a.key.compareTo(b.key),);
    return ordenada;
  }
}

/// Nome padrão para medidas.
class MedidasPadrao {
  static const String busto = 'Busto';
  static const String cintura = 'Cintura';
  static const String quadril = 'Quadril';
  static const String alturaDoQuadril = 'Altura do quadril';
}
