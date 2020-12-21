--configurations for sqlite3

PRAGMA FOREIGN_KEYs = ON;
.headers ON
.mode column

--drop tables

DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS professor;
DROP TABLE IF EXISTS occurrence;
DROP TABLE IF EXISTS class;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS degree;
DROP TABLE IF EXISTS degree_type;
DROP TABLE IF EXISTS enrollment;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS classroom;
DROP TABLE IF EXISTS janitor;
DROP TABLE IF EXISTS faculty;
DROP TABLE IF EXISTS covid;
DROP TABLE IF EXISTS person;

--CREATE TABLEs

CREATE TABLE person (
    id INTEGER PRIMARY KEY,   
    name TEXT NOT NULL,       --tag:
                              --1 = green (no contact with known sick people)       
    address TEXT,             --2 = yellow (indirect contact with a sick person)
    phone_number INTEGER,     --3 = red (direct contact with a sick)
    tag VARCHAR CHECK(tag>0 AND tag<4)  --4 = black (person that tested positive)
);

CREATE TABLE student (
    id INTEGER PRIMARY KEY REFERENCES person,
    degree INTEGER REFERENCES degree,
    faculty VARCHAR REFERENCES faculty
);

CREATE TABLE professor (
    id INTEGER PRIMARY KEY REFERENCES person,
    faculty VARCHAR REFERENCES faculty,
    classification TEXT
);

CREATE TABLE janitor (
    id INTEGER PRIMARY KEY REFERENCES person,
    email VARCHAR
);

CREATE TABLE faculty (
    acronym VARCHAR PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    address VARCHAR NOT NULL
);

CREATE TABLE classroom (
    code VARCHAR PRIMARY KEY, --e.g. "GA1", "101"...
    description TEXT, --e.g. "Auditório Geral 1" (opcional)
    faculty VARCHAR REFERENCES faculty,
    janitor INTEGER REFERENCES janitor
);

CREATE TABLE degree_type (
    code VARCHAR PRIMARY KEY, --e.g. '1'=1º ciclo, '2'=2º ciclo...
    name TEXT NOT NULL --e.g. licenciatura
);

CREATE TABLE degree (
    acronym VARCHAR PRIMARY KEY NOT NULL, --e.g. MIEEC
    name TEXT NOT NULL,                   --e.g. Mestrado Integrado em Engenharia Eletrotécnica e de Computadores
    faculty REFERENCES faculty,
    degree_type VARCHAR REFERENCES degree_type        
);

CREATE TABLE course (
    acronym VARCHAR PRIMARY KEY,                --e.g. SIBD
    name TEXT NOT NULL,                         --e.g. Sistemas de Informação e Bases de Dados
    degree VARCHAR NOT NULL REFERENCES degree
);

CREATE TABLE class (
    course VARCHAR REFERENCES course,   --e.g. SIBD
    number VARCHAR, --e.g. 03
    max_students INTEGER,   --30
    PRIMARY KEY (course, number)
);

CREATE TABLE enrollment (
    person_id INTEGER NOT NULL REFERENCES student,
    course_acronym VARCHAR NOT NULL REFERENCES course,
    class_number INTEGER REFERENCES class,
    date DATETIME NOT NULL
);

CREATE TABLE occurrence (   --every time a class happens
    course VARCHAR class,
    class_number VARCHAR class,
    id INTEGER NOT NULL,
    classroom VARCHAR NOT NULL REFERENCES classroom,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    PRIMARY KEY (course,class_number,id),
    FOREIGN KEY (course,class_number) REFERENCES class(course,number),
    CONSTRAINT start_time_less_than_end_time CHECK (start_time < end_time),
    CONSTRAINT start_time_within_semester CHECK (start_time between '2020-09-28 00:00:00' AND '2020-12-18 23:59:59'),
    CONSTRAINT end_time_within_semester CHECK (end_time between '2020-09-28 00:00:00' AND '2020-12-18 23:59:59')
);

CREATE TABLE attendance (
    id INTEGER PRIMARY KEY autoincrement,
    person_id INTEGER REFERENCES person,
    swipe DATETIME ,
    classroom VARCHAR NOT NULL REFERENCES classroom
);

CREATE TABLE covid (
    id INTEGER PRIMARY KEY autoincrement,
    person_id INTEGER REFERENCES person,
    result TEXT, 
    date DATETIME,
    CONSTRAINT test_result_valid CHECK (covid.result = 'positive' OR 'negative')
);
--INSERTS

--faculties:
INSERT INTO faculty (acronym,name,address)
VALUES ('FEUP',
        'Faculdade de Engenharia',
        'R. Dr. Roberto Frias s/n, 4200-465 Porto, Portugal');

INSERT INTO faculty (acronym,name,address)
VALUES ('FLUP',
        'Faculdade de Letras',
        'Via Panorâmica Edgar Cardoso s/n, 4150-564 Porto, Portugal');

INSERT INTO faculty (acronym,name,address)
VALUES ('FDUP',
        'Faculdade de Direito',
        'Rua dos Bragas 223, 4050-123 Porto, Portugal');

INSERT INTO faculty (acronym,name,address)
VALUES ('FEP',
        'Faculdade de Economia',
        'R. Dr. Roberto Frias 464, 4200-465 Porto, Portugal');


INSERT INTO faculty (acronym,name,address)
VALUES ('FBAUP',
        'Faculdade de Belas Artes',
        'Av. de Rodrigues de Freitas 265, 4049–021 Porto, Portugal');

--degree types:
INSERT INTO degree_type (code,name)
VALUES (1,
'Licenciatura');

INSERT INTO degree_type (code,name)
VALUES (2,
'Mestrado Integrado');

INSERT INTO degree_type (code,name)
VALUES (3,
'Mestrado');

INSERT INTO degree_type (code,name)
VALUES (4,
'Doutoramento');
--Degrees
INSERT INTO degree VALUES ('LCI', 'Licenciatura em Ciência da Informação', 'FEUP', 1);
INSERT INTO degree VALUES ('LCE-EMG', 'Licenciatura em Ciências de Engenharia - Engenharia de Minas e Geo-Ambiente', 'FEUP', 1);

INSERT INTO degree VALUES ('MIEEC', 'Mestrado Integrado em Engenharia Eletrotécnica e de Computadores', 'FEUP',2);
INSERT INTO degree VALUES ('MIEC', 'Mestrado Integrado em Engenharia Civil', 'FEUP', 2);
INSERT INTO degree VALUES ('MIEM', 'Mestrado Integrado em Engenharia Mecânica', 'FEUP', 2);

INSERT INTO degree VALUES ('MDI', 'Mestrado em Design Industrial', 'FEUP', 3);
INSERT INTO degree VALUES ('MEB', 'Mestrado em Engenharia Biomédica', 'FEUP', 3);
INSERT INTO degree VALUES ('MEINF', 'Mestrado em Engenharia da Informação', 'FEUP', 3);

INSERT INTO degree VALUES ('PDMAPI', 'Programa Doutoral em Informática', 'FEUP', 4);
INSERT INTO degree VALUES ('PRODEF', 'Programa Doutoral em Engenharia Física', 'FEUP', 4);

--Person:
INSERT INTO person VALUES (201700001,'Joao Miguel Tavares','Rua A, 1',1111111111,1);
INSERT INTO person VALUES (201700002,'Maria Carolina Alves','Rua B, 1',222222222,1);
INSERT INTO person VALUES (201700003,'Joana Ferreira','Rua C, 1',333333333,1);
INSERT INTO person VALUES (201700004,'Claudio Mendonça','Rua D, 1',444444444,1);
INSERT INTO person VALUES (201700005,'Luiz Soares','Rua E, 1',555555555,1);
INSERT INTO person VALUES (201700006,'Álvaro Silva','Rua F, 1',666666666,1);
INSERT INTO person VALUES (201700007,'Henrique Pereira','Rua G, 1',777777777,1);
INSERT INTO person VALUES (202100001,'El janitor','Rua G, 1',878787878,1);


INSERT INTO student VALUES (201700001,'MIEEC','FEUP');

INSERT INTO student VALUES (201700002,'MIEEC','FEUP');
INSERT INTO student VALUES (201700003,'MIEEC','FEUP');
INSERT INTO student VALUES (201700004,'MIEEC','FEUP');
INSERT INTO student VALUES (201700005,'MIEEC','FEUP');
INSERT INTO student VALUES (201700006,'MIEEC','FEUP');
INSERT INTO student VALUES (201700007,'MIEEC','FEUP');


INSERT INTO janitor VALUES (202100001,'jjj@feup');


--Courses:
--SIBD
INSERT INTO course (acronym,name,degree) VALUES ('SIBD', 'Sistemas de Informação e Bases de Dados', 'MIEEC');
INSERT INTO course (acronym,name,degree) VALUES ('PDSI', 'Processamento Digital de Sinal', 'MIEEC');
INSERT INTO course (acronym,name,degree) VALUES ('ELEC', 'Electrónica', 'MIEEC');
INSERT INTO course (acronym,name,degree) VALUES ('RCOM', 'Redes de Computadores', 'MIEEC');
INSERT INTO course (acronym,name,degree) VALUES ('ALGE', 'Álgebra', 'MIEM');

--Classes:
--SIBD01
INSERT INTO class (course,number,max_students) VALUES ('SIBD', '01', 30);
INSERT INTO class (course,number,max_students) VALUES ('SIBD', '02', 15);
INSERT INTO class (course,number,max_students) VALUES ('SIBD', '03', 8);
INSERT INTO class (course,number,max_students) VALUES ('RCOM', '01', 20);
INSERT INTO class (course,number,max_students) VALUES ('RCOM', '02', 20);
INSERT INTO class (course,number,max_students) VALUES ('ALGE', '01', 30);
INSERT INTO class (course,number,max_students) VALUES ('ALGE', '02', 30);
INSERT INTO class (course,number,max_students) VALUES ('ALGE', '03', 30);
INSERT INTO class (course,number,max_students) VALUES ('ALGE', '04', 30);
INSERT INTO class (course,number,max_students) VALUES ('ALGE', '05', 30);

--Classroom:
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('ILAB1','Laboratório de Informática 1','FEUP',202100001);
INSERT INTO classroom (code,description,faculty,janitor) VALUES ('ILAB2','Laboratório de Informática 2','FEUP',202100001);

--Occurrence:
--SIBD01
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',1,'ILAB1','2020-09-29 16:30:00','2020-09-29 18:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',2,'ILAB1','2020-09-30 17:30:00','2020-09-30 19:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',3,'ILAB1','2020-10-06 16:30:00','2020-10-06 18:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',4,'ILAB1','2020-10-07 17:30:00','2020-10-07 19:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',5,'ILAB1','2020-10-13 16:30:00','2020-10-13 18:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',6,'ILAB1','2020-10-14 17:30:00','2020-10-14 19:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',7,'ILAB1','2020-10-20 16:30:00','2020-10-20 18:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',8,'ILAB1','2020-10-21 17:30:00','2020-10-21 19:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',9,'ILAB1','2020-10-27 16:30:00','2020-10-27 18:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',10,'ILAB1','2020-10-28 17:30:00','2020-10-28 19:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',11,'ILAB1','2020-11-03 16:30:00','2020-11-03 18:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',12,'ILAB1','2020-11-04 17:30:00','2020-11-04 19:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',13,'ILAB1','2020-11-10 16:30:00','2020-11-10 18:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',14,'ILAB1','2020-11-11 17:30:00','2020-11-11 19:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',15,'ILAB1','2020-11-17 16:30:00','2020-11-17 18:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',16,'ILAB1','2020-11-18 17:30:00','2020-11-18 19:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',17,'ILAB1','2020-11-24 16:30:00','2020-11-24 18:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',18,'ILAB1','2020-11-25 17:30:00','2020-11-25 19:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',19,'ILAB1','2020-12-01 16:30:00','2020-12-01 18:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',20,'ILAB1','2020-12-02 17:30:00','2020-12-02 19:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',21,'ILAB1','2020-12-08 16:30:00','2020-12-08 18:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',22,'ILAB1','2020-12-09 17:30:00','2020-12-09 19:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',23,'ILAB1','2020-12-15 16:30:00','2020-12-15 18:30:00');
INSERT INTO occurrence (course,class_number,id,classroom,start_time,end_time) VALUES ('SIBD','01',24,'ILAB1','2020-12-16 17:30:00','2020-12-16 19:30:00');

--attendance:
INSERT INTO attendance VALUES (NULL,201700001,'2020-09-28 12:55:23','ILAB1');
INSERT INTO attendance VALUES (NULL,201700002,'2020-09-29 16:34:10','ILAB1');
INSERT INTO attendance VALUES (NULL,201700003,'2020-09-29 16:33:10','ILAB1');
INSERT INTO attendance VALUES (NULL,201700004,'2020-09-29 16:31:10','ILAB2');

INSERT INTO attendance VALUES (NULL,201700001,'2020-09-29 16:33:10','ILAB1');

INSERT INTO attendance VALUES (NULL,201700001,'2020-09-30 17:33:10','ILAB1');
INSERT INTO attendance VALUES (NULL,201700005,'2020-09-30 17:32:10','ILAB1');
INSERT INTO attendance VALUES (NULL,201700006,'2020-09-30 17:31:10','ILAB1');




--covid:
INSERT INTO covid VALUES (NULL,201700001, 'positive', '2020-10-09');
INSERT INTO covid VALUES (NULL,201700006, 'positive', '2020-10-20');

-- testing queries for interrogating the database later

--select student with email (no need to store email as
--a variable for students):
-- SELECT *, 'up' || id || '@' || faculty || '.up.pt' AS email
-- FROM student
-- join person using (id);



 