SELECT date_trunc('month', "DT_ATENDIMENTO")::date, COUNT(*) AS NUM from desfechos GROUP BY date_trunc('month', "DT_ATENDIMENTO")::date
ORDER BY NUM DESC;
