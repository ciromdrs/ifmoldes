CREATE DATABASE if_moldes;
USE if_moldes;

CREATE TABLE tabelas_de_medidas (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    data_criacao DATETIME NOT NULL,
    ultima_modificacao DATETIME NOT NULL
);

CREATE TABLE moldes (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    modelo VARCHAR(80) NOT NULL,
    medelista VARCHAR(80) NOT NULL,
    referencia VARCHAR(12) NOT NULL,
    imagem LONGBLOB NOT NULL,
    medidas_padrao JSON NOT NULL
);

CREATE TABLE partes (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    quantidade_cortes INT NOT NULL,
    imagem LONGBLOB NOT NULL,
    
    FOREIGN KEY molde_id
    REFERENCES moldes(id)
);

CREATE TABLE passos (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    descricao TEXT NOT NULL,
    medida INT,
    divisor FLOAT NOT NULL,
    incremento FLOAT NOT NULL

    FOREIGN KEY parte_id
    REFERENCES partes(id)
);