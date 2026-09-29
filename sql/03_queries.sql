-- Вывести абитуриентов, которые хотят поступать на образовательную программу 
-- «Мехатроника и робототехника» в отсортированном по фамилиям виде

SELECT e.name_enrollee FROM enrollee e
JOIN program_enrollee pe ON
pe.enrollee_id = e.enrollee_id
JOIN program p ON
p.program_id = pe.program_id
WHERE p.name_program LIKE 'Мехатроника и робототехника'
ORDER BY e.name_enrollee;

-- Вывести образовательные программы, на которые для поступления необходим предмет 
-- «Информатика». Программы отсортировать в обратном алфавитном порядке.

SELECT p.name_program from program p
JOIN program_subject ps ON
ps.program_id = p.program_id
JOIN subject s ON
s.subject_id = ps.subject_id
WHERE s.name_subject LIKE 'Информатика'
ORDER BY p.name_program DESC;

-- Вывести количество абитуриентов, сдавших ЕГЭ по каждому предмету, максимальное, минимальное и среднее значение баллов по предмету ЕГЭ.

SELECT s.name_subject, COUNT(es.enrollee_id) AS Количество, 
MAX(es.result) AS Максимум, MIN(es.result) AS Минимум,
ROUND(AVG(es.result),1) AS Среднее FROM subject s
JOIN enrollee_subject es
ON s.subject_id = es.subject_id
GROUP BY s.name_subject
ORDER BY s.name_subject






