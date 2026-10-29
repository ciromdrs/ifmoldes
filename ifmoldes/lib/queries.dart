Map<String, String> queries = {
  // parâmetros: data_criacao, ultima_modicacao, tabela
  'nova_tabela': '''
    INSERT (data_criacao, ultima_modificacao, tabela) INTO tabelas_de_medidas VALUES
    (?, ?, ?);
  ''',

  // parâmetros: modelo, modelista, referencia, imagem, medidas_padrao
  'novo_molde': '''
    INSERT (modelo, modelista, referencia, imagem, medidas_padrao) INTO moldes VALUES
    (?, ?, ?, ?, ?);
  ''',

  // parâmetros: nome, quantidade_cortes, imagem, molde_id
  'nova_parte': '''
    INSERT (nome, quantidade_cortes, imagem, molde_id) INTO partes VALUES
    (?, ?, ?, ?);
  ''',

  // parâmetros: descricao, medida, divisor, incremento
  'novo_passo': '''
    INSERT (descricao, medida, divisor, incremento) VALUES
    (?, ?, ?, ?)
  ''',

  // parâmetros, ultima_modificacao, tabela, id
  'alterar_tabela': '''
    UPDATE tabelas
    SET ultima_ultima_modificacao = ?,
        tabela = ?
    WHERE id = ?;
  ''',

  // parâmetros: modelo, modelista, referencia, imagem, medidas_padrao, id
  'alterar_molde': '''
    UPDATE moldes
    SET modelo = ?,
        modelista = ?,
        referencia - ?,
        imagem = ?,
        medidas_padrao = ?
    WHERE id = ?;
  ''',

  // parâmetros: nome, quantidade_cortes, imagem, id
  'alterar_parte': '''
    UPDATE partes
    SET nome = ?,
        quantidade_cortes = ?,
        imagem = ?
    WHERE id = ?
  ''',

  // parâmetros: descricao, medida, divisor, incremento, id
  'alterar_passo': '''
    UPDATE passos
    SET descricao = ?,
        medida = ?,
        divisor = ?,
        incremento = ?
    WHERE id = ?
  ''',

  // parâmetros: id
  'deletar_tabela': '''
    DELETE tabelas
    WHERE id = ?;
  ''',

  // parâmetros: id
  'deletar_molde': '''
    DELETE moldes
    WHERE id = ?;
  ''',

  // parâmetros: id
  'deletar_parte': '''
    DELETE partes
    WHERE id = ?;
  ''',

  // parâmetros: id
  'deletar_passo': '''
    DELETE passos
    WHERE id = ?;
  ''',
};