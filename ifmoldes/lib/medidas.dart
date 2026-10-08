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
  static const String busto                     = 'Busto';
  static const String cintura                   = 'Cintura';
  static const String quadril                   = 'Quadril';
  static const String alturaDoQuadril           = 'Altura do quadril';
  static const String comprimentoCorpoFrente    = 'Comprimento do corpo (frente)';
  static const String centroFrente              = 'Centro (frente)';
  static const String cavaFrente                = 'Cava (frente)';
  static const String alturaDoBusto             = 'Altura do busto';
  static const String separacaoDoBusto          = 'Separação do busto';
  static const String baseDoBojo                = 'Base do bojo';
  static const String comprimentoCorpoCostas    = 'Comprimento do corpo (costas)';
  static const String ombro                     = 'Ombro';
  static const String alturaDoCotovelo          = 'Altura do cotovelo';
  static const String comprimentoDaManga        = 'Comprimento da manga';
  static const String circunferenciaDoBraco     = 'Cincunferância do braço';
  static const String circunferenciaDoCotovelo  = 'Circunferência do cotovelo';
  static const String circunferenciaDoPulso     = 'Cincunferência do pulso';
  static const String punho                     = 'Punho';
  static const String alturaDoGancho            = 'Altura do gancho';
  static const String entrepernas               = 'Entre pernas';
  static const String circunferenciaDaCoxa      = 'Circunferência da coxa';
  static const String circunferenciaDoJoelho    = 'Circunferência do joelho';
  static const String circunferenciaDoTornozelo = 'Circunferência do tornozelo';
  static const String alturaDoJoelho            = 'Alltura do joelho';
  static const String circunferenciaDaCabeca    = 'Circunferência da cabeça';
}