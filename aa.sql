DELIMITER //
CREATE OR REPLACE PROCEDURE p_calculate_and_store(
    IN p_student_id INT,          -- Parámetro de entrada
    OUT p_result DECIMAL(4,2)     -- Parámetro de salida
)
BEGIN
    DECLARE v_count INT;           -- Variable local
    DECLARE v_sum DECIMAL(6,2);    -- Variable local
    
    -- Contar notas del estudiante
    SELECT COUNT(*), SUM(grade_value) 
    INTO v_count, v_sum
    FROM grades
    WHERE student_id = p_student_id;
    
    -- Calcular promedio
    IF v_count > 0 THEN
        SET p_result = v_sum / v_count;
    ELSE
        SET p_result = 0;
    END IF;
    
    -- Guardar en variable de usuario para uso posterior
    SET @last_calculation = p_result;
END //
DELIMITER ;

-- Uso del procedimiento
CALL p_calculate_and_store(6, @average);
SELECT @average AS 'Promedio', @last_calculation AS 'Última calculada';
