import 'package:ifmoldes/models.dart';
import 'package:ifmoldes/medidas.dart';

final List<TabelaDeMedidasModel> tabelaModelsExemplo = [
  TabelaDeMedidasModel(
    nome: 'Ana',
    tabela: TabelaDeMedidas({
      MedidasPadrao.busto: 88.0,
      MedidasPadrao.quadril: 96.0,
      MedidasPadrao.cintura: 72.0,
      MedidasPadrao.alturaDoQuadril: 20.0,
    }),
    dataCriacao: DateTime(2026, 1, 10),
    ultimaModificacao: DateTime(2026, 1, 15),
  ),
  TabelaDeMedidasModel(
    nome: 'Bruno',
    tabela: TabelaDeMedidas({
      MedidasPadrao.busto: 98.0,
      MedidasPadrao.quadril: 102.0,
      MedidasPadrao.cintura: 84.0,
      MedidasPadrao.alturaDoQuadril: 22.0,
    }),
    dataCriacao: DateTime(2026, 2, 5),
    ultimaModificacao: DateTime(2026, 2, 8),
  ),
  TabelaDeMedidasModel(
    nome: 'Carla',
    tabela: TabelaDeMedidas({
      MedidasPadrao.busto: 92.0,
      MedidasPadrao.quadril: 100.0,
      MedidasPadrao.cintura: 76.0,
      MedidasPadrao.alturaDoQuadril: 21.0,
    }),
    dataCriacao: DateTime(2026, 3, 12),
    ultimaModificacao: DateTime(2026, 3, 20),
  ),
  TabelaDeMedidasModel(
    nome: 'Daniel',
    tabela: TabelaDeMedidas({
      MedidasPadrao.busto: 104.0,
      MedidasPadrao.quadril: 108.0,
      MedidasPadrao.cintura: 90.0,
      MedidasPadrao.alturaDoQuadril: 23.0,
    }),
    dataCriacao: DateTime(2026, 4, 1),
    ultimaModificacao: DateTime(2026, 4, 3),
  ),
  TabelaDeMedidasModel(
    nome: 'Mariana',
    tabela: TabelaDeMedidas({
      MedidasPadrao.busto: 86.0,
      MedidasPadrao.quadril: 94.0,
      MedidasPadrao.cintura: 68.0,
      MedidasPadrao.alturaDoQuadril: 19.0,
    }),
    dataCriacao: DateTime(2026, 5, 18),
    ultimaModificacao: DateTime(2026, 5, 22),
  ),
];