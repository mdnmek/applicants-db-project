-- УДАЛЕНИЕ СУЩЕСТВУЮЩИХ ТАБЛИЦ (в обратном порядке)

DROP TABLE IF EXISTS enrollee_subject CASCADE;
DROP TABLE IF EXISTS program_enrollee CASCADE;
DROP TABLE IF EXISTS program_subject CASCADE;
DROP TABLE IF EXISTS enrollee_achievement CASCADE;
DROP TABLE IF EXISTS program CASCADE;
DROP TABLE IF EXISTS achievement CASCADE;
DROP TABLE IF EXISTS enrollee CASCADE;
DROP TABLE IF EXISTS subject CASCADE;
DROP TABLE IF EXISTS department CASCADE;

-- СОЗДАНИЕ НЕЗАВИСИМЫХ ТАБЛИЦ

-- Таблица department (Факультеты/Школы)
CREATE TABLE department (
    department_id SERIAL PRIMARY KEY,
    name_department VARCHAR(30) NOT NULL
);

-- Таблица subject (Предметы ЕГЭ)
CREATE TABLE subject (
    subject_id SERIAL PRIMARY KEY,
    name_subject VARCHAR(30) NOT NULL
);

-- Таблица enrollee (Абитуриенты)
CREATE TABLE enrollee (
    enrollee_id SERIAL PRIMARY KEY,
    name_enrollee VARCHAR(50) NOT NULL
);

-- Таблица achievement (Достижения)
CREATE TABLE achievement (
    achievement_id SERIAL PRIMARY KEY,
    name_achievement VARCHAR(30) NOT NULL,
    bonus INT NOT NULL
);

-- СОЗДАНИЕ ЗАВИСИМЫХ ТАБЛИЦ

-- Таблица program (Образовательные программы)
CREATE TABLE program (
    program_id SERIAL PRIMARY KEY,
    name_program VARCHAR(50) NOT NULL,
    department_id INT NOT NULL,
    plan INT NOT NULL,
    CONSTRAINT fk_program_department FOREIGN KEY (department_id) 
        REFERENCES department(department_id) ON DELETE CASCADE
);

-- Таблица enrollee_achievement (Связь абитуриентов и достижений)
CREATE TABLE enrollee_achievement (
    enrollee_achiev_id SERIAL PRIMARY KEY,
    enrollee_id INT NOT NULL,
    achievement_id INT NOT NULL,
    CONSTRAINT fk_enrollee_achievement_enrollee FOREIGN KEY (enrollee_id) 
        REFERENCES enrollee(enrollee_id) ON DELETE CASCADE,
    CONSTRAINT fk_enrollee_achievement_achievement FOREIGN KEY (achievement_id) 
        REFERENCES achievement(achievement_id) ON DELETE CASCADE
);

-- Таблица program_subject (Предметы, необходимые для программы)
CREATE TABLE program_subject (
    program_subject_id SERIAL PRIMARY KEY,
    program_id INT NOT NULL,
    subject_id INT NOT NULL,
    min_result INT NOT NULL,
    CONSTRAINT fk_program_subject_program FOREIGN KEY (program_id) 
        REFERENCES program(program_id) ON DELETE CASCADE,
    CONSTRAINT fk_program_subject_subject FOREIGN KEY (subject_id) 
        REFERENCES subject(subject_id) ON DELETE CASCADE
);

-- Таблица program_enrollee (Выбор абитуриентами программ)
CREATE TABLE program_enrollee (
    program_enrollee_id SERIAL PRIMARY KEY,
    program_id INT NOT NULL,
    enrollee_id INT NOT NULL,
    CONSTRAINT fk_program_enrollee_program FOREIGN KEY (program_id) 
        REFERENCES program(program_id) ON DELETE CASCADE,
    CONSTRAINT fk_program_enrollee_enrollee FOREIGN KEY (enrollee_id) 
        REFERENCES enrollee(enrollee_id) ON DELETE CASCADE
);

-- Таблица enrollee_subject (Баллы ЕГЭ абитуриентов)
CREATE TABLE enrollee_subject (
    enrollee_subject_id SERIAL PRIMARY KEY,
    enrollee_id INT NOT NULL,
    subject_id INT NOT NULL,
    result INT NOT NULL,
    CONSTRAINT fk_enrollee_subject_enrollee FOREIGN KEY (enrollee_id) 
        REFERENCES enrollee(enrollee_id) ON DELETE CASCADE,
    CONSTRAINT fk_enrollee_subject_subject FOREIGN KEY (subject_id) 
        REFERENCES subject(subject_id) ON DELETE CASCADE
);