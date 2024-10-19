USE LOCADORA_AUTOMOVEIS;

--  Número de vezes que um carro foi alugado
SELECT PLACA, COUNT(ID) AS "N DE ALUGUEIS" 
FROM CONTRATO
GROUP BY PLACA;

-- Número de vezes que um cliente alugou um carro
SELECT  NOME,  COUNT(DISTINCT PLACA) AS "N de Alugueis", contrato.CPF, cliente.CPF
FROM CONTRATO, cliente
WHERE contrato.CPF = cliente.CPF
GROUP BY contrato.CPF;

-- Número de contratos por ano
SELECT YEAR(DATA_INICIAL) AS ANO, COUNT(ID) AS "N DE CONTRATOS"
FROM CONTRATO
GROUP BY ANO
ORDER BY ANO;

-- Anos com menor e maior números de contratos e média ao ano
SELECT 
    MIN(contratos_por_ano.qtd_contratos) AS ano_com_menos_contratos,
    MAX(contratos_por_ano.qtd_contratos) AS ano_com_mais_contratos,
    AVG(contratos_por_ano.qtd_contratos) AS media_contratos_por_ano
FROM (
    SELECT YEAR(DATA_INICIAL) AS ano, COUNT(*) AS qtd_contratos
    FROM CONTRATO
    GROUP BY YEAR(DATA_INICIAL)
) AS contratos_por_ano;

-- Lista de clientes que alugaram todos os carros
SELECT NOME, CPF
FROM CLIENTE
WHERE NOT EXISTS (
    SELECT 1
    FROM VEICULO
    WHERE PLACA NOT IN (
        SELECT PLACA 
        FROM CONTRATO 
        WHERE CLIENTE.CPF = CONTRATO.CPF
    )
);