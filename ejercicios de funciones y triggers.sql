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
