-- 
-- Autor: [Julio Cruz]
-- Fecha: Enero 2026
-- Descripción: Consultas SQL de ejemplo para GradesDB
--              Cubre conceptos de consultas simples y avanzadas
-- 

USE GradesDB;

-- SELECT
-- ME DA TODAS LAS COLUMNAS DE LA TABLA ASIGNATURAS
SELECT * 
FROM subjects
;

-- Todas las columnas de la tabla asignaturas de IISSI
SELECT * 
FROM subjects s 
WHERE s.acronym= 'IISSI-1'
;

-- Columnas de nombre y acrónimo de asignaturas
SELECT s.subject_name, s.acronym
FROM subjects s
;

-- Columnas nombre, acrónimo y tipo de las asignaturas que son Formación Básica
SELECT s.subject_name, s.acronym, s.subject_type
FROM subjects s
WHERE s.subject_type = "Formación Básica"
;

-- JOIN
SELECT p.first_name, p.last_name, st.access_method
FROM students st
JOIN people p ON st.student_id = p.person_id
WHERE st.access_method = "Selectividad"
;

SELECT p.first_name, p.last_name, pr.category
FROM professors pr
JOIN people p ON pr.professor_id = p.person_id
WHERE pr.category= "Catedrático"
;

-- VISTAS
-- Vista profesor
CREATE OR REPLACE VIEW v_professors AS 
SELECT pr.professor_id, pr.category, p.person_id, p.dni, p.first_name, p.last_name, p.age, p.email
FROM professors pr
JOIN people p ON pr.professor_id = p.person_id
;

-- Test de como se ve la vista de profesor
SELECT *
FROM v_professors
;

-- Vista estudiantes
CREATE OR REPLACE VIEW v_students AS
SELECT st.student_id, st.access_method, p.person_id, p.dni, p.first_name, p.last_name, p.age, p.email
FROM students st
JOIN people p ON st.student_id = p.person_id
;

SELECT *
FROM v_students
;

-- Funciones
SELECT AVG(g.grade_value) AS average_grade
FROM grades g
WHERE g.group_id=1
;

SELECT SUM(s.credits) AS Suma_créditos
FROM subjects s
WHERE s.degree_id = 3
;

SELECT COUNT(*) AS Numero_estudiantes
FROM students st
;

SELECT MAX(g.grade_value) AS Nota_máxima
FROM grades g
;

SELECT MIN(g.grade_value) AS Nota_más_baja
FROM grades g
;

-- Condiciones múltiples

SELECT g.grade_id, g.grade_value, g.exam_call
FROM grades g
WHERE g.grade_value<5 OR g.grade_value>9
;

SELECT g.grade_id, g.grade_value, g.exam_call
FROM grades g
WHERE g.grade_value BETWEEN 5 AND 7
;

SELECT s.subject_name, s.credits
FROM subjects s
WHERE s.credits IN (6,12)
;

SELECT p.first_name, p.last_name, p.age
FROM people p
WHERE p.age BETWEEN 20 AND 30
;

-- DISTINCT: Eliminación de duplicados
SELECT DISTINCT g.group_name 
FROM groups g
;

SELECT DISTINCT s.subject_type
FROM subjects s
;

SELECT DISTINCT g.academic_year
FROM `groups` g
ORDER BY g.academic_year DESC
;

-- Subconsultas

SELECT MAX (g.grade_value) AS max_grade
FROM grades g
WHERE g.student_id = 6
;

SELECT DISTINCT ge.student_id
FROM group_enrollments ge
WHERE ge.group_id IN (
    SELECT g.group_id 
    FROM groups g 
    WHERE g.academic_year = 2024
)
;

SELECT s.subject_name, s.credits
FROM subjects s
WHERE s.credits > (SELECT AVG(credits) FROM subjects)
;

-- Like
SELECT p.first_name, p.last_name, p.dni
FROM people p
WHERE p.dni LIKE '%A';

SELECT s.subject_name
FROM subjects s
WHERE s.subject_name LIKE 'Fundamentos%';

SELECT p.first_name, p.last_name
FROM people p
WHERE p.first_name LIKE '_____';

-- Filtrado por fechas y años
SELECT g.group_name, g.activity, g.academic_year
FROM groups g
WHERE g.academic_year = 2024;


SELECT g.group_name, g.activity, g.academic_year
FROM groups g
WHERE g.academic_year BETWEEN 2020 AND 2023
ORDER BY g.academic_year;



