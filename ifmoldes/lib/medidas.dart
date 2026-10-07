/// Tabela de medidas de uma pessoa.
library;

extension type TabelaDeMedidas(Map<String, double> map) implements Map<String, double> {
  /// Atualiza os valores desta tabela a partir da [outra].
  /// Se alguma chave desta tabela não existir na [outra], o [valorPadrao] será usado.
  void atualizar(TabelaDeMedidas outra, double valorPadrao) {
    for (var entry in map.entries) {
      map[entry.key] = outra.map[entry.key] ?? valorPadrao;
    }
  }

  /// Apaga todas as entradas desta tabela e copia da [outra].
  void copy(TabelaDeMedidas outra) {
    map.clear();
    for (var entry in outra.entries) {
      map[entry.key] = entry.value;
    }
  }

  /// Retorna a instância como uma lista ordenada.
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
  // TODO: Adicionar demais nomes.
}