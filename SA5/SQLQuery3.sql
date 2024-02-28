-- Questão 1
SELECT * FROM lotes WHERE YEAR(datavalidade) = 2024;

-- Questão 2
SELECT COUNT(*) AS total_lotes_2025 FROM lotes WHERE YEAR(datavalidade) = 2025;

-- Questão 3
SELECT p.nomeproduto, COUNT(l.codproduto) AS total_lotes 
FROM produtos p
LEFT JOIN lotes l ON p.codproduto = l.codproduto
GROUP BY p.nomeproduto;

-- Questão 4
SELECT p.nomeproduto, SUM(l.valorlote) AS valor_total_lotes 
FROM produtos p
INNER JOIN lotes l ON p.codproduto = l.codproduto
GROUP BY p.nomeproduto;

-- Questão 5
SELECT * FROM lotes ORDER BY datavalidade;

-- Questão 6
SELECT * FROM lotes WHERE datavalidade BETWEEN '2024-02-01' AND '2026-06-30';

--Questão 7
IF NOT EXISTS (SELECT 1 FROM fabricantes WHERE nomefabricante = 'Ancora')
BEGIN
    INSERT INTO fabricantes (nomefabricante) VALUES ('Ancora');
END

IF NOT EXISTS (SELECT 1 FROM produtos WHERE nomeproduto = 'Sabonete de Glicerina')
BEGIN
    DECLARE @codfabricante INT;
    SELECT @codfabricante = codfabricante FROM fabricantes WHERE nomefabricante = 'Ancora';
    INSERT INTO produtos (nomeproduto, codfabricante) VALUES ('Sabonete de Glicerina', @codfabricante);
END
DECLARE @codproduto INT;
SELECT @codproduto = codproduto FROM produtos WHERE nomeproduto = 'Sabonete de Glicerina';

INSERT INTO lotes (datavalidade, precounitario, quantidade, valorlote, codproduto) 
VALUES ('2029-12-28', 3.78, 1223, 4625.94, @codproduto);

-- Questão 8
UPDATE lotes 
SET precounitario = precounitario * 0.85 
WHERE codproduto = (SELECT codproduto FROM produtos WHERE nomeproduto = 'Sabonete de Glicerina');

-- Questão 9
DECLARE @codproduto INT;
SELECT @codproduto = codproduto FROM produtos WHERE nomeproduto = 'Shampoo Anticaspa' AND codfabricante IN (SELECT codfabricante FROM fabricantes WHERE nomefabricante = 'Rexona');

DELETE FROM lotes WHERE codproduto = @codproduto;

DELETE FROM produtos WHERE codproduto = @codproduto;

-- Questão 10
ALTER TABLE lotes ALTER COLUMN precounitario DECIMAL(10, 2);

-- Questão 11
ALTER TABLE lotes ADD STATUSLOTE VARCHAR(9) DEFAULT 'Analise';

-- Questão 12
SELECT * FROM lotes;

UPDATE lotes
SET STATUSLOTE = 'Analise'
where numlote >=100;

UPDATE lotes
SET STATUSLOTE = 
    CASE numlote
        WHEN 107 THEN 'Recall'
        WHEN 113 THEN 'Liberado'
        WHEN 117 THEN 'Liberado'
        WHEN 108 THEN 'Recall'
        WHEN 116 THEN 'Recall'
        WHEN 112 THEN 'Liberado'
        WHEN 109 THEN 'Liberado'
        WHEN 114 THEN 'Liberado'
    END
WHERE numlote IN (107, 113, 117, 108, 116, 112, 109, 114);


-- Questão 13
SELECT STATUSLOTE, COUNT(*) AS quantidade FROM lotes GROUP BY STATUSLOTE;

-- Questão 14
SELECT f.nomefabricante, 
       COUNT(p.codproduto) AS total_produtos, 
       SUM(l.quantidade) AS total_produtos_em_lotes
FROM fabricantes f
LEFT JOIN produtos p ON f.codfabricante = p.codfabricante
LEFT JOIN lotes l ON p.codproduto = l.codproduto
GROUP BY f.nomefabricante;