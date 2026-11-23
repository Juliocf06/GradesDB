-- Ejemplo 1: Nota media del alumno
DELIMITER //
CREATE OR REPLACE FUNCTION f_student_average(p_student_id INT) RETURNS DECIMAL(4,2)
BEGIN 
	DECLARE v_average DECIMAL (4,2) DEFAULT 0;
	
	SELECT COALESCE(AVG(grade_value), 0) INTO v_average
	FROM grades
	WHERE student_id = p_student_id;
	RETURN v_average;
END //
DELIMITER ;
-- Ejecución
SELECT f_student_average(6);

-- Ejemplo 2: Indica si el alumno está matriculado en la asignatura
DELIMITER //
CREATE OR REPLACE FUNCTION f_is_student_enrolled(
    p_student_id INT,
    p_subject_id INT
)
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_exists INT;
    SELECT COUNT(*) INTO v_exists
    FROM subject_enrollments
    WHERE student_id = p_student_id
      AND subject_id = p_subject_id;
    RETURN v_exists > 0;
END//
DELIMITER ;
-- Ejecución
SELECT s.subject_id, s.subject_name,
       f_is_student_enrolled(6, s.subject_id) AS matriculado
FROM subjects s
WHERE s.degree_id = 3;

-- Ejemplo 3: Función para verificar límite de grupos por asignatura
DELIMITER //
CREATE OR REPLACE FUNCTION f_subject_group_limit_reached(p_subject_id INT, p_activity VARCHAR(15), p_academic_year YEAR)
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
	 DECLARE v_count INT;
	 DECLARE v_result BOOLEAN DEFAULT FALSE;	
	 
	 SELECT COUNT(*) INTO v_count
	 FROM `groups`
	 WHERE subject_id = p_subject_id AND activity = p_activity AND academic_year = p_academic_year;
	 
	 IF p_activity = 'Teoría' THEN SET v_result = (v_count >=1);
	 ELSEIF p_activity = 'Laboratorio' THEN SET v_result = (v_count >=2);
	 END IF;
	 
	 RETURN v_result;
	 END//
DELIMITER ;	 
-- Ejecución
SELECT f_subject_group_limit_reached(1, 'Teoría', 2025) AS 'Límite alcanzado';

-- Función auxiliar para triggers
DELIMITER //
CREATE OR REPLACE FUNCTION f_student_group_limit(p_student_id INT, p_subject_id INT, p_activity VARCHAR(15))
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE v_count INT;
	SELECT COUNT(*) INTO v_count
	FROM students_groups ge
	JOIN `groups` g ON g.group_id = ge.group_id
	WHERE ge.student_id = p_student_id AND g.subject_id = p_subject_id AND g.activity = p_activity;
	RETURN v_count >= 1;
END//
DELIMITER ;

-- Ejercicio 1
DELIMITER //
CREATE OR REPLACE FUNCTION f_count_student_grades(p_student_id INT, p_exam_call VARCHAR(20)) RETURNS DECIMAL(4,2)
BEGIN
	DECLARE v_notas INT;
	SELECT COUNT(*) INTO v_notas
	FROM grades
	WHERE p_student_id = student_id AND p_exam_call = exam_call;
	RETURN v_notas;
END //
DELIMITER ;

-- Ejercicio 2
DELIMITER //
CREATE OR REPLACE FUNCTION f_professor_total_credits(p_professor_id INT) RETURNS DECIMAL(4,1)
BEGIN
	DECLARE v_creditos DECIMAL(4,1);
	SELECT COALESCE(SUM(credits), 0) INTO v_creditos
	FROM teaching_loads
	WHERE p_professor_id = professor_id;
	RETURN v_creditos;
END //
DELIMITER ;