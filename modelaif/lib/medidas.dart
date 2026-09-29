/// Tabela de medidas de uma pessoa.
class TabelaDeMedidas {
  final String nome;
  final Map<String, double> medidas;

  const TabelaDeMedidas({
    this.nome = 'Sem nome',
    this.medidas = const {},
  });
}

/// Nome padrão para medidas.
class Medidas {
  static const String busto = 'Busto';
  static const String cintura = 'Cintura';
  static const String quadril = 'Quadril';
  static const String alturaDoQuadril = 'Altura do quadril';
}
