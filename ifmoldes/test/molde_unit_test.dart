import 'package:flutter_test/flutter_test.dart';
import 'package:ifmoldes/medidas.dart';
import 'package:ifmoldes/molde.dart';


void main() {
  group('Molde', () {
    test('armazena os valores recebidos no construtor', () {
      final partes = <Parte>[
        Parte(
          nome: 'Frente',
          quantidade: 1,
          imagem: 'frente.png',
          passos: <Passo>[],
        ),
      ];
      /// Evitei usar a classe MedidasPadrao. Nos testes de unidade, devemos 
      /// isolar ao máximo o código sendo executado.
      final tabela = TabelaDeMedidas({'Medida Exemplo': 100});

      final molde = Molde(
        modelo: 'Saia reta',
        modelista: 'Ana Silva',
        referencia: 'S2020',
        imagem: 'saia.png',
        tabelaPadrao: tabela,
        partes: partes,
      );

      expect(molde.modelo, 'Saia reta');
      expect(molde.modelista, 'Ana Silva');
      expect(molde.referencia, 'S2020');
      expect(molde.imagem, 'saia.png');
      expect(molde.tabelaPadrao, same(tabela));
      expect(molde.partes, same(partes));
    });
  });

  group('Parte', () {
    test('armazena os valores recebidos no construtor', () {
      final passos = <Passo>[Passo(descricao: 'Marque o tecido')];

      final parte = Parte(
        nome: 'Frente',
        quantidade: 2,
        imagem: 'frente.png',
        passos: passos,
      );

      expect(parte.nome, 'Frente');
      expect(parte.quantidade, 2);
      expect(parte.imagem, 'frente.png');
      expect(parte.passos, same(passos));
    });
  });

  group('Passo', () {
    test('usa divisor e incremento padrão', () {
      final passo = Passo(descricao: 'Trace a cintura');

      expect(passo.descricao, 'Trace a cintura');
      expect(passo.medida, isNull);
      expect(passo.divisor, 1);
      expect(passo.incremento, 0);
    });

    test('calcula a medida com divisor e incremento', () {
      final passo = Passo(
        descricao: 'Calcule um quarto da cintura com folga',
        medida: 'Medida Exemplo',
        divisor: 4,
        incremento: 2,
      );
      final tabela = TabelaDeMedidas({'Medida Exemplo': 100});

      expect(passo.medidaProporcional(tabela), 27);
    });
  });

  group('MedidaException', () {
    test('usa a mensagem padrão', () {
      expect(
        const MedidaException().toString(),
        'MedidaException: Ocorreu um problema com a(s) medida(s) utilizada(s).',
      );
    });

    test('usa a mensagem personalizada', () {
      expect(
        const MedidaException('Medida inválida').toString(),
        'MedidaException: Medida inválida',
      );
    });
  });
}
