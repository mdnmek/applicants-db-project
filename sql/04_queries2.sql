-- удалить таблицу, если она уже существует
DROP TABLE IF EXISTS applicant;

--создать вспомогательную таблицу applicant,  куда включить id образовательной программы, id абитуриента, сумму баллов абитуриентов (столбец itog)
CREATE TABLE applicant AS
SELECT 
	pe.program_id, 
	pe.enrollee_id, 
	SUM(es.result) AS itog
FROM program_enrollee pe
JOIN enrollee_subject es 
    ON es.enrollee_id = pe.enrollee_id
JOIN program_subject ps 
    ON ps.program_id = pe.program_id 
    AND ps.subject_id = es.subject_id
GROUP BY 
    pe.program_id, 
    pe.enrollee_id
ORDER BY 
    pe.program_id ASC, 
    itog DESC;

