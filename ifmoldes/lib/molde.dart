import 'package:ifmoldes/medidas.dart';

/// Representa um molde de roupa.
///
/// Guarda informações como nome e referência do modelo e a lista de partes
/// que o compõem.
class Molde {
  /// Nome do tipo de peça representado pelo molde. Ex.: Saia reta.
  String modelo;

  /// Nome do modelista ou responsável pela criação do molde. Ex.: Ana Silva.
  String modelista;

  /// Lista de partes que compõem o molde.
  List<Parte> partes;

  /// Código ou referência única para identificar o molde. Ex.: S2020.
  String referencia;

  /// Caminho para a imagem principal do molde.
  String imagem;

  /// Tabela com medidas padrão para este molde.
  TabelaDeMedidas tabelaPadrao;

  /// Cria uma instância de [Molde].
  Molde({
    required this.modelo,
    required this.modelista,
    required this.referencia,
    required this.imagem,
    required this.tabelaPadrao,
    required this.partes,
  });
}

/// Uma parte individual de um molde.
class Parte {
  /// Nome da parte do molde. Ex.: Frente, Costas, Manga.
  String nome;

  /// Quantidade de cortes da parte no processo de produção.
  int quantidade;

  /// Caminho ou referência da imagem da parte do molde.
  String imagem;

  /// Passo-a-passo para cortar a parte.
  List<Passo> passos;

  /// Cria uma instância de [Parte].
  Parte({
    required this.nome,
    required this.quantidade,
    required this.imagem,
    required this.passos,
  });
}


/// Um passo para cortar uma parte de um molde.
class Passo {
  /// Descrição de como executar o passo. Ex.: "Trace uma reta do ponto A ao ponto B".
  String descricao;

  /// Medida de referência usada neste passo.
  String? medida;

  /// Divisor da medida a cortar no passo. Ex.: 1/4 da cintura.
  double divisor;

  /// Incremento da medida a cortar no passo. Ex.: +1cm para a cintura.
  double incremento;

  Passo({required this.descricao, this.medida, this.divisor = 1, this.incremento = 0});

  /// Calcula a medida proporcionalmente à tabela informada.
  double medidaProporcional(TabelaDeMedidas tabela) {
    // TODO: Verificar se é melhor retornar 0 ou lançar exceção caso a medida não exista na tabela.
    double m = tabela.map[medida] ?? 0;
    m /= divisor;
    m += incremento;
    return m;
  }
}