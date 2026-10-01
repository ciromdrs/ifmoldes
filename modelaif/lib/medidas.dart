/// Tabela de medidas de uma pessoa.

extension TabelaDeMedidas<K, V> on Map<String, dynamic> {
  /// Nome da tabela. Ex.: "Alice", "Padrão M", etc.
  String get nome {
    return this['nome'];
  }

  set nome(String value) {
    this['nome'] = value;
  }

  /// Retorna a instância como uma lista ordenada.
  List<MapEntry<String, dynamic>> toList() {
    List<MapEntry<String, dynamic>> ordenada = entries.toList();
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
