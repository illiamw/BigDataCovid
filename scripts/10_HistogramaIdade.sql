-- O histograma equi-largura de distribui¸c˜ao das idades dos pacientes, de maneira que a largura de cada bin do histograma corresponda a ’duas idades’. Atente para que todas as ’idades poss´ıveis’, desde0 at´e a maior idade registrada esteja representada no histograma

SELECT Floor((2020-"AA_NASCIMENTO")/45.00)*45 as Idade, Count(*) AS Conta
FROM pacientes
GROUP BY Idade
ORDER BY Idade;

--- Vizualização de cada idade nos bins

WITH MinMax AS (SELECT  Min((2020-"AA_NASCIMENTO")) Mi, Max((2020-"AA_NASCIMENTO")) Ma
FROM pacientes)

SELECT (2020-"AA_NASCIMENTO") as Idade,
Width_bucket((2020-"AA_NASCIMENTO"), (SELECT Mi FROM MinMax),(SELECT Ma FROM MinMax) + 1, 2) as Bin,
Count(*) Conta
FROM pacientes
GROUP BY Idade ORDER BY Idade;

-- Alternativa
WITH MinMax AS (SELECT 2 AS NB, Min(2020-"AA_NASCIMENTO") AS Mi, Max(2020-"AA_NASCIMENTO") AS Ma FROM pacientes)
SELECT Trunc((SELECT Mi FROM MinMax)+
((Bin-1)*((SELECT Ma FROM MinMax)-(SELECT Mi FROM MinMax))/
(SELECT NB FROM MinMax)),2) AS Ini,
Trunc(((SELECT Mi FROM MinMax) +
(Bin)*((SELECT Ma FROM MinMax)-(SELECT Mi FROM MinMax))/
(SELECT NB FROM MinMax)),2) AS Fim, Qtd
FROM (
SELECT Width_Bucket((2020-"AA_NASCIMENTO"), (SELECT Mi FROM MinMax),
(SELECT Ma FROM MinMax)+1, (SELECT NB FROM MinMax)) AS Bin,
Count(*) as Qtd
FROM pacientes
GROUP BY Bin ORDER BY Bin) Histo;


--  Modifique esse comando para gerar um histograma equi-largura com 10 bins.


SELECT Floor((2020-"AA_NASCIMENTO")/9.00)*9 as Idade, Count(*) AS Conta
FROM pacientes
GROUP BY Idade
ORDER BY Idade;


--- Vizualização de cada idade nos bins

WITH MinMax AS (SELECT  Min((2020-"AA_NASCIMENTO")) Mi, Max((2020-"AA_NASCIMENTO")) Ma
FROM pacientes)
SELECT (2020-"AA_NASCIMENTO") as Idade,
Width_bucket((2020-"AA_NASCIMENTO"), (SELECT Mi FROM MinMax),
(SELECT Ma FROM MinMax) + 1, 10) as Bin,
Count(*) Conta
FROM pacientes
GROUP BY Idade ORDER BY Idade;


-- Alternativa
WITH MinMax AS (SELECT 10 AS NB, Min(2020-"AA_NASCIMENTO") AS Mi, Max(2020-"AA_NASCIMENTO") AS Ma FROM pacientes)
SELECT Trunc((SELECT Mi FROM MinMax)+
((Bin-1)*((SELECT Ma FROM MinMax)-(SELECT Mi FROM MinMax))/
(SELECT NB FROM MinMax)),2) AS Ini,
Trunc(((SELECT Mi FROM MinMax) +
(Bin)*((SELECT Ma FROM MinMax)-(SELECT Mi FROM MinMax))/
(SELECT NB FROM MinMax)),2) AS Fim, Qtd
FROM (
SELECT Width_Bucket((2020-"AA_NASCIMENTO"), (SELECT Mi FROM MinMax),
(SELECT Ma FROM MinMax)+1, (SELECT NB FROM MinMax)) AS Bin,
Count(*) as Qtd
FROM pacientes
GROUP BY Bin ORDER BY Bin) Histo;
