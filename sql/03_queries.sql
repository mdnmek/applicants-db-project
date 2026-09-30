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
ORDER BY s.name_subject;

-- вывести образовательные программы, для которых минимальный балл 
-- ЕГЭ по каждому предмету больше или равен 40 баллам

SELECT p.name_program FROM program p
JOIN program_subject ps
ON ps.program_id = p.program_id
GROUP BY p.name_program
HAVING MIN(min_result)>=40
ORDER BY p.name_program;

-- вывести образовательные программы, которые имеют самый большой план набора
SELECT name_program, plan FROM program
ORDER BY plan DESC LIMIT 1;

-- посчитать, сколько дополнительных баллов получит каждый абитуриент
SELECT e.name_enrollee, COALESCE(SUM(a.bonus), 0) AS Бонус 
FROM enrollee e
LEFT JOIN enrollee_achievement ea
ON e.enrollee_id = ea.enrollee_id
LEFT JOIN achievement a
ON a.achievement_id = ea.achievement_id
GROUP BY e.enrollee_id, e.name_enrollee
ORDER BY e.name_enrollee;

-- вывести сколько человек подало заявление на каждую образовательную программу и конкурс на нее
SELECT d.name_department, p.name_program, p.plan,
COUNT(pe.enrollee_id) AS Количество, 
ROUND((COUNT(pe.enrollee_id)/p.plan),2) AS Конкурс
FROM department d
JOIN program p
ON p.department_id = d.department_id
JOIN program_enrollee pe
ON pe.program_id = p.program_id
GROUP BY d.name_department, p.name_program, p.plan
ORDER BY Конкурс DESC;

-- Вывести образовательные программы, на которые для поступления необходимы предмет «Информатика» и «Математика» 
SELECT p.name_program FROM program p
JOIN program_subject ps
ON ps.program_id = p.program_id
JOIN subject s
ON s.subject_id = ps.subject_id
WHERE s.name_subject IN ('Информатика', 'Математика')
GROUP BY p.name_program
HAVING COUNT(s.name_subject)=2
ORDER BY p.name_program;

-- Посчитать количество баллов каждого абитуриента на каждую образовательную программу, на которую он подал заявление, по результатам ЕГЭ.
SELECT p.name_program, e.name_enrollee, SUM(result) AS itog 
FROM program p
JOIN program_enrollee pe
ON pe.program_id = p.program_id
JOIN enrollee e
ON e.enrollee_id = pe.enrollee_id
JOIN enrollee_subject es
ON es.enrollee_id = e.enrollee_id
JOIN program_subject ps 
ON ps.program_id = p.program_id 
AND ps.subject_id = es.subject_id
GROUP BY p.name_program, e.name_enrollee, e.enrollee_id
ORDER BY p.name_program, itog DESC;

-- вывести название образовательной программы и фамилию тех абитуриентов, которые подавали документы на эту образовательную программу, но не могут быть зачислены на нее.
SELECT DISTINCT p.name_program, e.name_enrollee
FROM program p
JOIN program_enrollee pe 
ON pe.program_id = p.program_id
JOIN enrollee e 
ON e.enrollee_id = pe.enrollee_id
JOIN program_subject ps 
ON ps.program_id = p.program_id
JOIN enrollee_subject es 
ON es.enrollee_id = e.enrollee_id 
AND es.subject_id = ps.subject_id
WHERE 
es.result < ps.min_result
ORDER BY 
p.name_program ASC, 
e.name_enrollee ASC;

-- вывести студентов, у которых в достижениях есть любой знак ГТО
SELECT e.name_enrollee, a.name_achievement FROM enrollee e
JOIN enrollee_achievement ea
ON ea.enrollee_id = e.enrollee_id
JOIN achievement a
ON a.achievement_id = ea.achievement_id
WHERE a.name_achievement LIKE '%ГТО'
ORDER BY e.name_enrollee;

