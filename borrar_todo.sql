USE grades_db;
DELIMITER //
CREATE OR REPLACE PROCEDURE p_delete_all_data()
BEGIN

    DELETE FROM grades;
    DELETE FROM teaching_loads;
    DELETE FROM students_groups;
    DELETE FROM subject_enrollments;
    DELETE FROM `groups`;
    DELETE FROM subjects;
    DELETE FROM students;
    DELETE FROM professors;
    DELETE FROM degrees;
    DELETE FROM people;
END //
DELIMITER ;
