-- CONSULTA 1
SELECT P."ID_PACIENTE", P."CD_MUNICIPIO", P."AA_NASCIMENTO", M.AA_MIN, M.AA_MAX FROM pacientes P,
(SELECT "CD_MUNICIPIO", Min("AA_NASCIMENTO") AA_MIN, Max("AA_NASCIMENTO") AA_MAX FROM pacientes
GROUP BY "CD_MUNICIPIO") M
WHERE (P."CD_MUNICIPIO"= M."CD_MUNICIPIO" AND P."AA_NASCIMENTO" = M.AA_MAX) OR
(P."CD_MUNICIPIO"= M."CD_MUNICIPIO" AND P."AA_NASCIMENTO" = M.AA_MIN);

-- CONSULTA 2

WITH M as (SELECT "CD_MUNICIPIO", Min("AA_NASCIMENTO") AA_MIN, Max("AA_NASCIMENTO") AA_MAX FROM pacientes
GROUP BY "CD_MUNICIPIO")

SELECT P."ID_PACIENTE", P."CD_MUNICIPIO", P."AA_NASCIMENTO", M.AA_MIN, M.AA_MAX FROM pacientes P, M
WHERE (P."CD_MUNICIPIO"= M."CD_MUNICIPIO" AND P."AA_NASCIMENTO" = M.AA_MAX) OR
(P."CD_MUNICIPIO"= M."CD_MUNICIPIO" AND P."AA_NASCIMENTO" = M.AA_MIN);

--CONSULTA 3

SELECT * FROM (SELECT "ID_PACIENTE", "CD_MUNICIPIO", "AA_NASCIMENTO", Min("AA_NASCIMENTO") OVER(PARTITION BY "CD_MUNICIPIO") AA_MIN,
Max("AA_NASCIMENTO") OVER(PARTITION BY "CD_MUNICIPIO") AA_MAX FROM pacientes) P
WHERE (P."AA_NASCIMENTO" = P.AA_MIN) OR (P."AA_NASCIMENTO" = P.AA_MAX);