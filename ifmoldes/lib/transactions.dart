import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ifmoldes/queries.dart';
import 'package:ifmoldes/medidas.dart';

void novaTabela(Database db, TabelaDeMedidas medidas) async {
  await db.transaction((txn) async {
    DateTime dtAtual = DateTime.now();
    txn.rawInsert(
      queries['nova_tabela']!,
      [dtAtual, dtAtual, medidas]);
  });
}

void novoMolde(
  Database db,
  String modelo,
  String modelista,
  String referencia,
  Image imagem,
  TabelaDeMedidas medidasPadrao
) async {
  await db.transaction((txn) async {
    txn.rawInsert(
      queries['novo_molde']!,
      [modelo, modelista, referencia, imagem, medidasPadrao]);
  });
}

void novaParte(Database db, String nome, int quantidadeCortes, Image imagem, int moldeId) async {
  await db.transaction((txn) async {
    txn.rawInsert(
      queries['nova_parte']!,
      [nome, quantidadeCortes, imagem, moldeId]);
  });
}

void novoPasso(
  Database db,
  String descricao,
  double medida,
  int divisor,
  int incremento
) async {
  await db.transaction((txn) async {
    txn.rawInsert(
      queries['novo_passo']!,
      [descricao, medida, divisor, incremento]);
  });
}

void editarTabela(Database db, TabelaDeMedidas medidas, int id) async {
  await db.transaction((txn) async {
    txn.rawUpdate(
      queries['alterar_tabela']!,
      [DateTime.now(), medidas, id]
    );
  });
}

void editarMolde(
  Database db,
  String modelo,
  String modelista,
  String referencia,
  Image imagem,
  TabelaDeMedidas medidasPadrao,
  int id
) async {
  await db.transaction((txn) async {
    txn.rawUpdate(
      queries['alterar_molde']!,
      [modelo, modelista, referencia, imagem, medidasPadrao, id]
    );
  });
}

void editarParte(Database db, String nome, int quantidadeCortes, Image imagem, int id) async {
  await db.transaction((txn) async {
    await txn.rawUpdate(
      queries['alterar_parte']!,
      [nome, quantidadeCortes, imagem, id]
    );
  });
}

void editarPasso(
  Database db,
  String descricao,
  double medida,
  int divisor,
  int incremento,
  int id
) async {
  await db.transaction((txn) async {
    await txn.rawUpdate(
      queries['alterar_passo']!,
      [descricao, medida, divisor, incremento, id]
    );
  });
}

void deletarMedida(Database db, int id) async {
  await db.transaction((txn) async {
    await txn.rawDelete(queries['deletar_medida']!);
  });
}

void deletarMolde(Database db, int id) async {
  await db.transaction((txn) async {
    await txn.rawDelete(queries['deletar_molde']!);
  });
}

void deletarParte(Database db, int id) async {
  await db.transaction((txn) async {
    await txn.rawDelete(queries['deletar_parte']!);
  });
}

void deletarPasso(Database db, int id) async {
  await db.transaction((txn) async {
    await txn.rawDelete(queries['deletar_passo']!);
  });
}