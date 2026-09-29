import 'medidas.dart';

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

  /// Manequim com medidas padrão para este molde.
  TabelaDeMedidas medidasPadrao;

  /// Cria uma instância de [Molde].
  Molde({
    required this.modelo,
    required this.modelista,
    required this.referencia,
    required this.imagem,
    required this.medidasPadrao,
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

  /// Nome da medida de referência usada neste passo.
  String? medida;

  /// Divisor da medida a cortar no passo. Ex.: 1/4 da cintura.
  double divisor;

  /// Incremento da medida a cortar no passo. Ex.: +1cm para a cintura.
  double incremento;

  Passo({required this.descricao, this.medida, this.divisor = 1, this.incremento = 0});
}

final TabelaDeMedidas manequimExemplo = TabelaDeMedidas(
  medidas: {
    Medidas.quadril: 110,
    Medidas.cintura: 96,
    Medidas.alturaDoQuadril: 21,
    'Comprimento da saia': 59,
  }
);

final List<Molde> moldesExemplo = [
  Molde(
    modelo: 'Saia Reta',
    modelista: "Ana Silva",
    referencia: "S2020",
    imagem: "moldes/saia_reta/saia_reta__Principal.png",
    medidasPadrao: TabelaDeMedidas(
      medidas: {
        Medidas.quadril: 100,
        Medidas.cintura: 88,
        Medidas.alturaDoQuadril: 19,
        'Altura da saia': 54,
      }
    ),
    partes: [
      Parte(
        nome: "Frente",
        quantidade: 1,
        imagem: 'moldes/saia_reta/saia_reta__Frente.png',
        passos: [
          Passo(
            descricao:
                "Traçar uma reta do Ponto 1 ao Ponto 2 de tamanho ¼ do Quadril + 1 cm",
            divisor: 4,
            incremento: 1,
            medida: Medidas.quadril
          ),
          Passo(
            descricao:
                "Traçar uma reta do Ponto 1 ao Ponto 3 do Ponto 2 ao Ponto 4 e unir o Ponto 3 ao Ponto 4. Tamanho = Comprimento da Saia + 1,5 cm",
            incremento: 1.5,
            medida: 'Comprimento da saia'
          ),
          Passo(
            descricao: "Marcar do Ponto 1 ao Ponto 5 = ¼ da Cintura +1 cm",
            divisor: 4,
            incremento: 1,
            medida: Medidas.cintura
          ),
          Passo(
            descricao:
                "Marcar do Ponto 1 ao 7 e do Ponto 2 ao 6 = ALTURA DO QUADRIL",
                medida: Medidas.alturaDoQuadril
          ),
        ],
      ),
      Parte(
        nome: "Costas",
        quantidade: 1,
        imagem: 'moldes/saia_reta/saia_reta__Costas.png',
        passos: [
          Passo(
            descricao: "Traçar uma reta do Ponto 1 ao Ponto 2 = ¼ DO QUADRIL + 1cm",
            divisor: 4,
            incremento: 1,
            medida: Medidas.quadril
          ),
          Passo(
            descricao: "Traçar uma reta do Ponto 1 ao 3 e do 2 ao 4 e unir o Ponto 3 ao 4 = COMPRIMENTO DA SAIA + 2 cm",
            medida: 'Comprimento da saia',
            incremento: 2,
          ),
          Passo(
            descricao: "Marcar do Ponto 1 ao 5 = ¼ da CINTURA +1cm",
            medida: Medidas.cintura,
            divisor: 4,
            incremento: 1,
          ),
          Passo(
            descricao: "Marcar do Ponto 1 ao 7 e do Ponto 2 ao 6 = ALTURA DO QUADRIL",
            medida: Medidas.alturaDoQuadril,
          ),
          Passo(
            descricao: "Ligar o Ponto 6 ao 7",
          ),
          Passo(
            descricao: "Marcar o Ponto 1 ao 8 = 2 cm",
          ),
          Passo(
            descricao: "PENCE = Marcar o centro entre o Ponto 1 e o Ponto 2 e marcar 3cm e comprimento 12 cm",
          ),
        ],
      ),
      Parte(
        nome: "Cós",
        quantidade: 1,
        imagem: 'moldes/saia_reta/saia_reta__Cos.png',
        passos: [
          Passo(
            descricao: 'Ponto 1 ao Ponto 2 = CINTURA + 2cm',
            medida: Medidas.cintura,
            incremento: 2,
          ),
          Passo(
            descricao: 'Ponto 1 ao 3 e 2 ao 4 = 6cm',
          ),
        ]
      ),
    ],
  ),
  Molde(
    modelo: 'Calça Jeans',
    modelista: "Bottini",
    referencia: "C2020",
    imagem: "exmplo.png",
    medidasPadrao: TabelaDeMedidas(),
    partes: [
      Parte(
        nome: "Exemplo",
        quantidade: 1,
        imagem: "exemplo.png",
        passos: [],
      ),
    ],
  ),
  Molde(
    modelo: 'Camiseta',
    modelista: "Modelista Exemplo",
    referencia: "C2020",
    imagem: "exmplo.png",
    medidasPadrao: TabelaDeMedidas(),
    partes: [
      Parte(
        nome: "Exemplo",
        quantidade: 1,
        imagem: "exemplo.png",
        passos: [],
      ),
    ],
  ),
  Molde(
    modelo: 'Vestido',
    modelista: "Modelista Exemplo",
    referencia: "V2020",
    medidasPadrao: TabelaDeMedidas(),
    imagem: "exmplo.png",
    partes: [
      Parte(
        nome: "Exemplo",
        quantidade: 1,
        imagem: "exemplo.png",
        passos: []
      ),
    ],
  ),
  Molde(
    modelo: 'Short',
    modelista: "Modelista Exemplo",
    referencia: "S2020",
    imagem: "exmplo.png",
    medidasPadrao: TabelaDeMedidas(),
    partes: [
      Parte(
        nome: "Exemplo",
        quantidade: 1,
        imagem: "exemplo.png",
        passos: []
      ),
    ],
  ),
];
