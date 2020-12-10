PRAGMA foreign_keys = ON;
.headers on
.mode column

drop table if exists person;
drop table if exists student;
drop table if exists professor;
drop table if exists janitor;
drop table if exists faculty;
drop table if exists degree_type;
drop table if exists degree;
drop table if exists course;
drop table if exists class;
drop table if exists class_schedule;
drop table if exists classroom;

create table person (
    id integer primary key,
    name text not null,       --tag:
    tax_id integer unique,    --1 = green (no contact with known sick people)
    address text,             --2 = yellow (indirect contact with a sick person)
    phone_number integer,     --3 = red (direct contact with a sick)
    tag integer
    CHECK(tag>0 and tag<5)  --4 = black (person that tested positive)
);

create table student (
    person_id integer primary key references person(id),
    email varchar, --as 'up' + cast(id as varchar) + '@' + cast(faculty as varchar) + 'up.pt'
    degree integer unique references degree,
    faculty varchar references faculty
);

create table professor (
    person_id integer primary key references person(id),
    email varchar,
    classification integer -- 0 = full time professor; 1 = part time professor (could be a student or a researcher)
);
--------------
create table janitor (
    person_id integer primary key references person(id)
);
--------------
create table faculty (
    acronym varchar primary key,
    name text not null unique,
    address varchar not null
);

create table degree_type (
    code integer primary key, --e.g. 1=1º ciclo, 2=2º ciclo...
    name text not null --e.g. licenciatura
);

create table degree (
    acronym varchar primary key not null, --e.g. MIEEC
    name text not null,                   --e.g. Mestrado Integrado em Engenharia Eletrotécnica e de Computadores
    faculty references faculty,
    degree_code references degree_type
);

create table course (
    acronym varchar primary key,                --e.g. SIBD
    name text not null,                         --e.g. Sistemas de Informação e Bases de Dados
    degree varchar not null references degree
);

create table class (
    course_acronym varchar references course,   --e.g. SIBD
    num integer, --e.g. 03
    max_students integer,   --30
    PRIMARY KEY (course_acronym, num)
);
--------------
create table class_schedule (
    student_id integer not null references student,
    course_acronym varchar not null references course,
    class_number integer references class,
    classroom_number references classroom,
    date_start_time text not null,
    date_end_time text not null,
    CHECK(datetime(date_end_time) > datetime(date_start_time))
);
--------------
create table classroom (
    class_number integer references class,
    janitor_id integer references janitor,
    faculty_acronym references faculty
);
--------------

INSERT INTO faculty VALUES ('FEUP', 'Faculdade de Engenharia da Universidade do Porto', 'R. Dr. Roberto Frias, 4200-465 Porto');
INSERT INTO faculty VALUES ('FLUP', 'Faculdade de Letras da Universidade do Porto', 'Via Panorâmica Edgar Cardoso, 4150-564 Porto');
INSERT INTO faculty VALUES ('FEP', 'Faculdade de Economia da Universidade do Porto', 'R. Dr. Roberto Frias, 4200-464 Porto');
INSERT INTO faculty VALUES ('FAUP', 'Faculdade de Arquitetura da Universidade do Porto', 'Via Panorâmica Edgar Cardoso, 4150-564 Porto');

INSERT INTO degree_type VALUES (1, 'Licenciatura');
INSERT INTO degree_type VALUES (2, 'Mestrado');
INSERT INTO degree_type VALUES (3, 'Mestrado Integrado');
INSERT INTO degree_type VALUES (4, 'Doutoramento');

-- só coloquei cenas para a feup para já
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
INSERT INTO course VALUES ('SIBD', 'Sistemas de Informação e Bases de Dados', 'MIEEC');
INSERT INTO course VALUES ('PDSI', 'Processamento Digital de Sinal', 'MIEEC');
INSERT INTO course VALUES ('ELEC', 'Electrónica', 'MIEEC');
INSERT INTO course VALUES ('RCOM', 'Redes de Computadores', 'MIEEC');
INSERT INTO course VALUES ('ALGE', 'Álgebra', 'MIEM');
  -- nao está a dar para colocar mais que uma UC igual noutro curso
--INSERT INTO course VALUES ('ALGE', 'Álgebra', 'MIEC');
--INSERT INTO course VALUES ('ALGE', 'Álgebra', 'MIEEC');

INSERT INTO class VALUES ('SIBD', 1, 15);
INSERT INTO class VALUES ('SIBD', 2, 15);
INSERT INTO class VALUES ('SIBD', 3, 8);
INSERT INTO class VALUES ('RCOM', 1, 20);
INSERT INTO class VALUES ('RCOM', 2, 20);
INSERT INTO class VALUES ('ALGE', 1, 30);
INSERT INTO class VALUES ('ALGE', 2, 30);
INSERT INTO class VALUES ('ALGE', 3, 30);
INSERT INTO class VALUES ('ALGE', 4, 30);
INSERT INTO class VALUES ('ALGE', 5, 30);

-- !!!!!!! nao faço a menor ideia de como vamos criar os horários tho, se calhar é melhor criar no website

-- aqui no classroom temos de arranjar primeiro os janitors antes de atribuir salas
INSERT INTO person (1, 'EXEMPLO_JANITOR', 0, 'Casa', 12345, 4);
INSERT INTO janitor(1);

-- nao esta a dar, nao sei porque
--INSERT INTO classroom (SIBD1, 1, 'FEUP');
--INSERT INTO classroom (SIBD2, 1, 'FEUP');
--INSERT INTO classroom (SIBD3, 1, 'FEUP');
--INSERT INTO classroom (RCOM1, 1, 'FEUP');
--INSERT INTO classroom (RCOM2, 1, 'FEUP');
--INSERT INTO classroom (ALGE1, 1, 'FEUP');
