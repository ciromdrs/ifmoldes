import 'package:ifmoldes/medidas.dart';

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

final List<TabelaDeMedidasModel> medidasExemplo = [
  TabelaDeMedidasModel(
    nome: 'Ana',
    tabela: TabelaDeMedidas({
      'busto': 88.0,
      'quadril': 96.0,
      'cintura': 72.0,
      'altura do quadril': 20.0,
    }),
    dataCriacao: DateTime(2026, 1, 10),
    ultimaModificacao: DateTime(2026, 1, 15),
  ),
  TabelaDeMedidasModel(
    nome: 'Bruno',
    tabela: TabelaDeMedidas({
      'busto': 98.0,
      'quadril': 102.0,
      'cintura': 84.0,
      'altura do quadril': 22.0,
    }),
    dataCriacao: DateTime(2026, 2, 5),
    ultimaModificacao: DateTime(2026, 2, 8),
  ),
  TabelaDeMedidasModel(
    nome: 'Carla',
    tabela: TabelaDeMedidas({
      'busto': 92.0,
      'quadril': 100.0,
      'cintura': 76.0,
      'altura do quadril': 21.0,
    }),
    dataCriacao: DateTime(2026, 3, 12),
    ultimaModificacao: DateTime(2026, 3, 20),
  ),
  TabelaDeMedidasModel(
    nome: 'Daniel',
    tabela: TabelaDeMedidas({
      'busto': 104.0,
      'quadril': 108.0,
      'cintura': 90.0,
      'altura do quadril': 23.0,
    }),
    dataCriacao: DateTime(2026, 4, 1),
    ultimaModificacao: DateTime(2026, 4, 3),
  ),
  TabelaDeMedidasModel(
    nome: 'Mariana',
    tabela: TabelaDeMedidas({
      'busto': 86.0,
      'quadril': 94.0,
      'cintura': 68.0,
      'altura do quadril': 19.0,
    }),
    dataCriacao: DateTime(2026, 5, 18),
    ultimaModificacao: DateTime(2026, 5, 22),
  ),
];