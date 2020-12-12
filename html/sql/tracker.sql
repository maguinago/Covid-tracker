--configurations for sqlite3

PRAGMA foreign_keys = ON;
.headers on
.mode column

--drop tables

drop table if exists student;
drop table if exists professor;
drop table if exists occurrence;
drop table if exists class;
drop table if exists course;
drop table if exists degree;
drop table if exists degree_type;
drop table if exists enrollment;
drop table if exists attendance;
drop table if exists classroom;
drop table if exists janitor;
drop table if exists faculty;
drop table if exists person;

--create tables

create table person (
    id integer primary key autoincrement,   
    name text not null,       --tag:
                              --1 = green (no contact with known sick people)       
    address text,             --2 = yellow (indirect contact with a sick person)
    phone_number integer,     --3 = red (direct contact with a sick)
    tag varchar CHECK(tag>0 and tag<4)  --4 = black (person that tested positive)
);

create table student (
    id integer primary key references person,
    degree integer references degree,
    faculty varchar references faculty
);

create table professor (
    id integer primary key references person,
    faculty varchar references faculty,
    classification text
);

create table janitor (
    id integer primary key references person,
    email varchar
);

create table faculty (
    acronym varchar primary key,
    name text not null unique,
    address varchar not null
);

create table classroom (
    code varchar primary key, --e.g. "GA1", "101"...
    description text, --e.g. "Auditório Geral 1" (opcional)
    faculty varchar references faculty,
    janitor integer references janitor
);

create table degree_type (
    code varchar primary key, --e.g. '1'=1º ciclo, '2'=2º ciclo...
    name text not null --e.g. licenciatura
);

create table degree (
    acronym varchar primary key not null, --e.g. MIEEC
    name text not null,                   --e.g. Mestrado Integrado em Engenharia Eletrotécnica e de Computadores
    faculty references faculty,
    degree_type varchar references degree_type        
);

create table course (
    acronym varchar primary key,                --e.g. SIBD
    name text not null,                         --e.g. Sistemas de Informação e Bases de Dados
    degree varchar not null references degree
);

create table class (
    course varchar references course,   --e.g. SIBD
    number varchar, --e.g. 03
    max_students integer,   --30
    primary key (course, number)
);

create table enrollment (
    student_id integer not null references student,
    course_acronym varchar not null references course,
    class_number integer references class,
    date datetime not null
);

create table occurrence (   --every time a class happens
    course varchar class,
    class_number varchar class,
    id integer not null,
    classroom varchar not null references classroom,
    start_time datetime not null,
    end_time datetime not null,
    primary key (course,class_number,id),
    foreign key (course,class_number) references class(course,number),
    constraint start_time_less_than_end_time CHECK (start_time < end_time),
    constraint start_time_within_semester CHECK (start_time between '2020-09-28 00:00:00' and '2020-12-18 23:59:59'),
    constraint end_time_within_semester CHECK (end_time between '2020-09-28 00:00:00' and '2020-12-18 23:59:59')
);

create table attendance (
    id integer primary key autoincrement,
    student_id integer references person,
    swipe datetime ,
    classroom varchar not null references classroom
);

--INSERTS

--faculties:
insert into faculty (acronym,name,address)
values ('FEUP',
        'Faculdade de Engenharia',
        'R. Dr. Roberto Frias s/n, 4200-465 Porto, Portugal');

insert into faculty (acronym,name,address)
values ('FLUP',
        'Faculdade de Letras',
        'Via Panorâmica Edgar Cardoso s/n, 4150-564 Porto, Portugal');

insert into faculty (acronym,name,address)
values ('FDUP',
        'Faculdade de Direito',
        'Rua dos Bragas 223, 4050-123 Porto, Portugal');

insert into faculty (acronym,name,address)
values ('FEP',
        'Faculdade de Economia',
        'R. Dr. Roberto Frias 464, 4200-465 Porto, Portugal');


insert into faculty (acronym,name,address)
values ('FBAUP',
        'Faculdade de Belas Artes',
        'Av. de Rodrigues de Freitas 265, 4049–021 Porto, Portugal');

--degree types:
insert into degree_type (code,name)
values (1,
'Licenciatura');

insert into degree_type (code,name)
values (2,
'Mestrado Integrado');

insert into degree_type (code,name)
values (3,
'Mestrado');

insert into degree_type (code,name)
values (4,
'Doutoramento');

insert into degree (acronym,name,faculty,degree_type)
values ('MIEEC',
        'Mestrado Integrado em Engenharia Eletrotécnica e de
        Computadores',
        'FEUP',2);

--Person:
insert into person (id,name,address,phone_number,tag) values (20210000,'Joao','Rua A, 1',111,1);
insert into person (id,name,address,phone_number,tag) values (null,'Maria','Rua AB, 1',222,1);
insert into person (id,name,address,phone_number,tag) values (null,'Joana','Rua AC, 1',333,1);

insert into student (id,degree,faculty) values (20210000,'MIEEC','FEUP');
insert into janitor (id,email) values (20210001,'jjj@feup');


--Courses:
--SIBD
insert into course (acronym,name,degree) values ('SIBD','Sistemas de Informação e Bases de Dados','MIEEC');

--Classes:
--SIBD01
insert into class (course,number,max_students) values ('SIBD',01,30);

--Classroom:
insert into classroom (code,description,faculty,janitor)
     values ('ILAB1','Laboratório de Informática 1','FEUP',20210001);

--Occurence:
--SIBD1
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,1,'ILAB1','2020-09-29 16:30:00','2020-09-29 18:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,2,'ILAB1','2020-09-30 17:30:00','2020-09-30 19:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,3,'ILAB1','2020-10-06 16:30:00','2020-10-06 18:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,4,'ILAB1','2020-10-07 17:30:00','2020-10-07 19:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,5,'ILAB1','2020-10-13 16:30:00','2020-10-13 18:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,6,'ILAB1','2020-10-14 17:30:00','2020-10-14 19:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,7,'ILAB1','2020-10-20 16:30:00','2020-10-20 18:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,8,'ILAB1','2020-10-21 17:30:00','2020-10-21 19:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,9,'ILAB1','2020-10-27 16:30:00','2020-10-27 18:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,10,'ILAB1','2020-10-28 17:30:00','2020-10-28 19:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,11,'ILAB1','2020-11-03 16:30:00','2020-11-03 18:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,12,'ILAB1','2020-11-04 17:30:00','2020-11-04 19:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,13,'ILAB1','2020-11-10 16:30:00','2020-11-10 18:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,14,'ILAB1','2020-11-11 17:30:00','2020-11-11 19:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,15,'ILAB1','2020-11-17 16:30:00','2020-11-17 18:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,16,'ILAB1','2020-11-18 17:30:00','2020-11-18 19:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,17,'ILAB1','2020-11-24 16:30:00','2020-11-24 18:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,18,'ILAB1','2020-11-25 17:30:00','2020-11-25 19:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,19,'ILAB1','2020-12-01 16:30:00','2020-12-01 18:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,20,'ILAB1','2020-12-02 17:30:00','2020-12-02 19:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,21,'ILAB1','2020-12-08 16:30:00','2020-12-08 18:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,22,'ILAB1','2020-12-09 17:30:00','2020-12-09 19:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,23,'ILAB1','2020-12-15 16:30:00','2020-12-15 18:30:00');
insert into occurrence (course,class_number,id,classroom,start_time,end_time) values ('SIBD',1,24,'ILAB1','2020-12-16 17:30:00','2020-12-16 19:30:00');

--attendance:
insert into attendance (id,student_id,swipe,classroom)
values (null,20210000,'2020-09-28 12:55:23','ILAB1');

insert into attendance (id,student_id,swipe,classroom)
values (null,20210000,'2020-09-29 16:33:10','ILAB1');

insert into attendance (id,student_id,swipe,classroom)
values (null,20210000,'2020-09-29 16:33:10','ILAB1');

-- testing queries for interrogating the database later

--select student with email (no need to store email as
--a variable for students):
-- SELECT *, 'up' || id || '@' || faculty || '.up.pt' AS email
-- FROM student
-- join person using (id);

select *
  from attendance
    join occurrence
        on attendance.swipe
        between start_time
    and end_time
where attendance.classroom = occurrence.classroom
  and occurrence.course='SIBD'
  and occurrence.class_number='1'
  and occurrence.start_time like '2020-09-29%';
