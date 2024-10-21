USE LOCADORA_AUTOMOVEIS;

--  Número de vezes que um carro foi alugado
SELECT PLACA, COUNT(ID) AS "N DE ALUGUEIS" 
FROM CONTRATO
GROUP BY PLACA
ORDER BY COUNT(ID);

-- Número de vezes que um cliente alugou um carro
SELECT  NOME,  COUNT(PLACA) AS "N de Alugueis", contrato.CPF
FROM CONTRATO, cliente
WHERE contrato.CPF = cliente.CPF
GROUP BY contrato.CPF;

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

SELECT ANO AS "Ano com mais contratos"
FROM CONTRATOS_POR_ANO
WHERE QTD IN (
	SELECT MAX(QTD)
	FROM CONTRATOS_POR_ANO
);