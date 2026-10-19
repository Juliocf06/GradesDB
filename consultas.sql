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



