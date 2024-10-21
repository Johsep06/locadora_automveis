-- CREATE DATABASE LOCADORA_AUTOMOVEIS;
USE LOCADORA_AUTOMOVEIS;

-- Criação das tabelas do banco de dados
CREATE TABLE CLIENTE (
	CPF 		CHAR(11),
    NOME 		VARCHAR(100) 	NOT NULL,
    ENDERECO 	VARCHAR(100),
    
    PRIMARY KEY(CPF)
);

CREATE TABLE MODELO (
	ID 			INT 			AUTO_INCREMENT,
    TIPO 		VARCHAR(100) 	NOT NULL,
    MODELO 		VARCHAR(100) 	NOT NULL,
    MARCA 		VARCHAR(100) 	NOT NULL,
    
    PRIMARY KEY(ID)
);

CREATE TABLE VEICULO (
	PLACA 		CHAR(7),
    ANO 		YEAR 			NOT NULL,
    CHASSI 		VARCHAR(17) 	NOT NULL,
	COR 		VARCHAR(20),
    MODELO_ID 	INT 			NOT NULL,
    PRIMARY KEY(PLACA),
    FOREIGN KEY(MODELO_ID)
		REFERENCES MODELO(ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE MANUTENCAO(
	ID 					INT 	NOT NULL AUTO_INCREMENT,
    MODELO_ID 			INT 	NOT NULL,
    DATA_MANUTENCAO 	DATE 	NOT NULL,
    VALOR 				FLOAT 	NOT NULL DEFAULT 0,
    DESCRICAO 			TEXT,
    
    PRIMARY KEY(ID),
    FOREIGN KEY(MODELO_ID)
		REFERENCES MODELO(ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE CONTRATO (
	ID 				INT 			AUTO_INCREMENT,
    CPF 			CHAR(11) 		NOT NULL,
    PLACA 			VARCHAR(11) 	NOT NULL,
    VALOR_SEG 		FLOAT 			DEFAULT 0,
    DATA_INICIAL 	DATE 			NOT NULL,
    DATA_LIMITE 	DATE 			NOT NULL,
    DIARIA 			FLOAT 			NOT NULL DEFAULT 0,
    VALOR 			FLOAT 			DEFAULT 0,
    
    PRIMARY KEY(ID),
    FOREIGN KEY(CPF)
		REFERENCES CLIENTE(CPF)
        ON DELETE NO ACTION,
	FOREIGN KEY(PLACA)
		REFERENCES VEICULO(PLACA)
        ON DELETE CASCADE
);

CREATE TABLE HISTORICO_MANUTENCAO(
	ID 				INT 	AUTO_INCREMENT,
	MANUTENCAO_ID 	INT 	NOT NULL,
	MODELO_ID 		INT 	NOT NULL,
	CUSTO_MEDIO 	FLOAT 	DEFAULT 0,
	DATA_MANUTENCAO DATE 	NOT NULL,
     
	PRIMARY KEY(ID),
	FOREIGN KEY(MANUTENCAO_ID)
		REFERENCES MANUTENCAO(ID)
        ON DELETE NO ACTION,
 	FOREIGN KEY(MODELO_ID)
		REFERENCES MODELO(ID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);