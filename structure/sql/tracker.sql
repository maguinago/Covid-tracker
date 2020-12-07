PRAGMA foreign_keys = ON;
.headers on
.mode columns

drop table if exists student;
drop table if exists professor;
drop table if exists janitor;
drop table if exists person;
drop table if exists class;
drop table if exists class_schedule;
drop table if exists course;
drop table if exists degree;
drop table if exists classroom;
drop table if exists faculty;
drop table if exists degree_type;

create table person (
    id integer PRIMARY KEY AUTOINCREMENT,
    name text NOT NULL,       --tag:
    tax_id integer unique,    --1 = green (no contact with known sick people)
    address text,             --2 = yellow (indirect contact with a sick person)
    phone_no integer,     --3 = red (direct contact with a sick)
    tag integer
    CHECK(tag>0 and tag<5)  --4 = black (person that tested positive)
);

create table student (
    person_id integer PRIMARY KEY REFERENCES person,
    email varchar, --as 'up' + cast(id as varchar) + '@' + cast(faculty as varchar) + 'up.pt'
    degree integer unique REFERENCES degree,
    faculty varchar REFERENCES faculty
);

create table professor (
    person_id integer PRIMARY KEY REFERENCES person,
    email varchar,
    classification integer -- 0 = full time professor; 1 = part time professor (could be a student or a researcher)
);
--------------
create table janitor (
    person_id integer PRIMARY KEY REFERENCES person
);
--------------
create table faculty (
    acronym varchar PRIMARY KEY,
    name text NOT NULL unique,
    address varchar NOT NULL
);

create table degree_type (
    code integer PRIMARY KEY, --e.g. 1=1º ciclo, 2=2º ciclo...
    name text NOT NULL --e.g. licenciatura
);

create table degree (
    acronym varchar PRIMARY KEY, --e.g. MIEEC
    name text NOT NULL,                   --e.g. Mestrado Integrado em Engenharia Eletrotécnica e de Computadores
    faculty REFERENCES faculty,
    degree_code REFERENCES degree_type
);

create table course (
    id integer PRIMARY KEY AUTOINCREMENT,   --criei um ID para a UC mas honestamente preferia tornar a PRIMARY KEY (acronym, degree): ALGEBRA de MIEEC; ALGEBRA de MIEM; ALGEBRA de MIEC; ....
    acronym varchar,                --e.g. SIBD
    name text NOT NULL,                         --e.g. Sistemas de Informação e Bases de Dados
    degree varchar NOT NULL REFERENCES degree
);

create table class (
    course_acronym varchar REFERENCES course,   --e.g. SIBD
    no integer NOT NULL, --e.g. 03
    max_students integer,   --30
    PRIMARY KEY (course_acronym, no)
);
--------------
create table class_schedule (
    student_id integer NOT NULL REFERENCES student,
    course_acronym varchar NOT NULL REFERENCES course,
    class_no integer REFERENCES class,
    classroom_number REFERENCES classroom,
    date_start_time text NOT NULL,
    date_end_time text NOT NULL,
    CHECK(datetime(date_end_time) > datetime(date_start_time))
);
--------------
create table classroom (
    course_acronym varchar, -- REFERENCES class(course_acronym),
    num integer,  --REFERENCES class(num),
    janitor_id REFERENCES janitor,
    faculty_acronym REFERENCES faculty,
    FOREIGN KEY (course_acronym, num) REFERENCES class (course_acronym, num)
);
--------------  INSERT INTO classroom VALUES ('SIBD' 1, 1, 'FEUP');

INSERT INTO faculty VALUES ('FEUP', 'Faculdade de Engenharia da Universidade do Porto', 'R. Dr. Roberto Frias, 4200-465 Porto');
INSERT INTO faculty VALUES ('FLUP', 'Faculdade de Letras da Universidade do Porto', 'Via Panorâmica Edgar Cardoso, 4150-564 Porto');
INSERT INTO faculty VALUES ('FEP', 'Faculdade de Economia da Universidade do Porto', 'R. Dr. Roberto Frias, 4200-464 Porto');
INSERT INTO faculty VALUES ('FAUP', 'Faculdade de Arquitetura da Universidade do Porto', 'Via Panorâmica Edgar Cardoso, 4150-564 Porto');

INSERT INTO degree_type VALUES (1, 'Licenciatura');
INSERT INTO degree_type VALUES (2, 'Mestrado');
INSERT INTO degree_type VALUES (3, 'Mestrado Integrado');
INSERT INTO degree_type VALUES (4, 'Doutoramento');


INSERT INTO degree VALUES ('LCI', 'Licenciatura em Ciência da Informação', 'FEUP', 1);
INSERT INTO degree VALUES ('LCE-EMG', 'Licenciatura em Ciências de Engenharia - Engenharia de Minas e Geo-Ambiente', 'FEUP', 1);
INSERT INTO degree VALUES ('MDI', 'Mestrado em Design Industrial', 'FEUP', 2);
INSERT INTO degree VALUES ('MEB', 'Mestrado em Engenharia Biomédica', 'FEUP', 2);
INSERT INTO degree VALUES ('MEINF', 'Mestrado em Engenharia da Informação', 'FEUP', 2);
INSERT INTO degree VALUES ('MIEEC', 'Mestrado Integrado em Engenharia Electrotécnica e de Computadores', 'FEUP', 3);
INSERT INTO degree VALUES ('MIEC', 'Mestrado Integrado em Engenharia Civil', 'FEUP', 3);
INSERT INTO degree VALUES ('MIEM', 'Mestrado Integrado em Engenharia Mecânica', 'FEUP', 3);
INSERT INTO degree VALUES ('PDMAPI', 'Programa Doutoral em Informática', 'FEUP', 4);
INSERT INTO degree VALUES ('PRODEF', 'Programa Doutoral em Engenharia Física', 'FEUP', 4);

-- só coloquei algumas UCs que eu me lembrava do meu curso, temos de aumentar a variedade depois
INSERT INTO course VALUES (1, 'SIBD', 'Sistemas de Informação e Bases de Dados', 'MIEEC');
INSERT INTO course VALUES (2, 'PDSI', 'Processamento Digital de Sinal', 'MIEEC');
INSERT INTO course VALUES (3, 'ELEC', 'Electrónica', 'MIEEC');
INSERT INTO course VALUES (4, 'RCOM', 'Redes de Computadores', 'MIEEC');
INSERT INTO course VALUES (5, 'ALGE', 'Álgebra', 'MIEM');

INSERT INTO course VALUES (6, 'ALGE', 'Álgebra', 'MIEC');
INSERT INTO course VALUES (7, 'ALGE', 'Álgebra', 'MIEEC');

INSERT INTO class VALUES (1, 1, 15);  -- 1 = SIBD; 1 = no_class => SIBD1; 15 = max_capaxity
INSERT INTO class VALUES (1, 2, 15);  -- 1 = SIBD; 2 = no_class => SIBD2; 15 = max_capaxity
INSERT INTO class VALUES (1, 3, 8);   -- 1 = SIBD; 3 = no_class => SIBD3; 8 = max_capaxity
INSERT INTO class VALUES (4, 1, 20);  -- 4 = RCOM; 1 = no_class => RCOM1; 20 = max_capaxity
INSERT INTO class VALUES (4, 2, 20);  -- 4 = RCOM; 2 = no_class => RCOM2; 20 = max_capaxity
INSERT INTO class VALUES (5, 1, 30);
INSERT INTO class VALUES (5, 2, 30);
INSERT INTO class VALUES (5, 3, 30);
INSERT INTO class VALUES (5, 4, 30);
INSERT INTO class VALUES (5, 5, 30);

-- aqui no classroom temos de arranjar primeiro os janitors antes de atribuir salas
INSERT INTO person VALUES (1, 'EXEMPLO_JANITOR', 0, 'Casa', 12345, 4);
INSERT INTO janitor VALUES (1);

-- INSERT INTO classroom VALUES ('SIBD', 1, 1, 'FEUP');
-- INSERT INTO classroom VALUES ('SIBD2', 1, 'FEUP');
-- INSERT INTO classroom (SIBD3, 1, 'FEUP');
-- INSERT INTO classroom (RCOM1, 1, 'FEUP');
-- INSERT INTO classroom (RCOM2, 1, 'FEUP');
-- INSERT INTO classroom (ALGE1, 1, 'FEUP');
-- janitor_id REFERENCES janitor,
-- faculty_acronym REFERENCES faculty,
-- FOREIGN KEY (course_acronym, num) REFERENCES class (course_acronym, num)
