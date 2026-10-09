import 'package:ifmoldes/molde.dart';
import 'package:ifmoldes/medidas.dart';

final List<Molde> moldesExemplo = [
  Molde(
    modelo: 'Saia Reta',
    modelista: "Edson Bottini",
    referencia: "S2020",
    imagem: "assets/moldes/saia_reta/saia_reta__Principal.png",
    tabelaPadrao: TabelaDeMedidas({
      MedidasPadrao.quadril: 100,
      MedidasPadrao.cintura: 88,
      MedidasPadrao.alturaDoQuadril: 19,
      'Altura da saia': 54,
    }),
    partes: [
      Parte(
        nome: "Frente",
        quantidade: 1,
        imagem: 'assets/moldes/saia_reta/saia_reta__Frente.png',
        passos: [
          Passo(
            descricao:
                "Traçar uma reta do Ponto 1 ao Ponto 2",
            divisor: 4,
            incremento: 1,
            medida: MedidasPadrao.quadril
          ),
          Passo(
            descricao:
                "Traçar uma reta do Ponto 1 ao Ponto 3 do Ponto 2 ao Ponto 4 e unir o Ponto 3 ao Ponto 4",
            incremento: 1.5,
            medida: 'Altura da saia'
          ),
          Passo(
            descricao: "Marcar do Ponto 1 ao Ponto 5",
            divisor: 4,
            incremento: 1,
            medida: MedidasPadrao.cintura
          ),
          Passo(
            descricao:
                "Marcar do Ponto 1 ao 7 e do Ponto 2 ao 6",
                medida: MedidasPadrao.alturaDoQuadril
          ),
        ],
      ),
      Parte(
        nome: "Costas",
        quantidade: 1,
        imagem: 'assets/moldes/saia_reta/saia_reta__Costas.png',
        passos: [
          Passo(
            descricao: "Traçar uma reta do Ponto 1 ao Ponto 2",
            divisor: 4,
            incremento: 1,
            medida: MedidasPadrao.quadril
          ),
          Passo(
            descricao: "Traçar uma reta do Ponto 1 ao 3 e do 2 ao 4 e unir o Ponto 3 ao 4",
            medida: 'Comprimento da saia',
            incremento: 2,
          ),
          Passo(
            descricao: "Marcar do Ponto 1 ao 5",
            medida: MedidasPadrao.cintura,
            divisor: 4,
            incremento: 1,
          ),
          Passo(
            descricao: "Marcar do Ponto 1 ao 7 e do Ponto 2 ao 6",
            medida: MedidasPadrao.alturaDoQuadril,
          ),
          Passo(
            descricao: "Ligar o Ponto 6 ao 7",
          ),
          Passo(
            descricao: "Marcar o Ponto 1 ao 8",
            incremento: 2,
          ),
          Passo(
            descricao: "PENCE = Marcar o centro entre o Ponto 1 e o Ponto 2 e marcar 3cm e comprimento 12 cm",
          ),
        ],
      ),
      Parte(
        nome: "Cós",
        quantidade: 1,
        imagem: 'assets/moldes/saia_reta/saia_reta__Cos.png',
        passos: [
          Passo(
            descricao: 'Ponto 1 ao Ponto 2',
            medida: MedidasPadrao.cintura,
            incremento: 2,
          ),
          Passo(
            descricao: 'Ponto 1 ao 3 e 2 ao 4',
            incremento: 6,
          ),
        ]
      ),
    ],
  ),
  Molde(
    modelo: 'Calça Jeans',
    modelista: "Ana Silva",
    referencia: "C2020",
    imagem: "exemplo.png",
    tabelaPadrao: TabelaDeMedidas({}),
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
    modelista: "Bruno Souza",
    referencia: "C2020",
    imagem: "exemplo.png",
    tabelaPadrao: TabelaDeMedidas({}),
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
    modelista: "Carla Santos",
    referencia: "V2020",
    tabelaPadrao: TabelaDeMedidas({}),
    imagem: "exemplo.png",
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
    modelista: "Daniel Araújo",
    referencia: "S2020",
    imagem: "exemplo.png",
    tabelaPadrao: TabelaDeMedidas({}),
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