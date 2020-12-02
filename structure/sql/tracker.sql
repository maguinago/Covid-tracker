--configurations for sqlite3

PRAGMA foreign_keys = ON;
.headers on
.mode column

--drop tables

drop table if exists person;
drop table if exists student;
drop table if exists professor;
drop table if exists janitor;
drop table if exists course;
drop table if exists class;
drop table if exists campus;
drop table if exists faculty;
drop table if exists classroom;
drop table if exists degree_type;
drop table if exists degree;
drop table if exists enrollment;
drop table if exists occurrence;
drop table if exists attendance;

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
    email varchar, --as 'up' + cast(id as varchar) + '@' + cast(faculty as varchar) + 'up.pt'
    degree integer references degree,
    faculty varchar references faculty
);

create table professor (
    id integer primary key references person,
    email varchar,
    classification text
);

create table faculty (
    acronym varchar primary key,
    name text not null unique,
    address varchar not null
);

create table degree_type (
    code varchar primary key, --e.g. 1=1º ciclo, 2=2º ciclo...
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
    course_acronym varchar references course,   --e.g. SIBD
    number integer, --e.g. 03
    max_students integer,   --30
    primary key (course_acronym, number)
);

create table enrollment (
    student_id integer not null references student,
    course_acronym varchar not null references course,
    class_number integer references class,
    date datetime not null
);

create table occurrence (
    id integer primary key autoincrement,
    course_acronym varchar references course,
    class_number integer references class,
    start_time datetime not null,
    end_time datetime not null
);

create table attendance (
    student_id integer not null references student,
    course_acronym varchar references enrollment,
    ocurrence_id integer not null references ocurrence
);

--inserts

insert into person (id,name,address,phone_number,tag) values (null,'AAA','Rua A, 1',111,1);
insert into faculty (acronym,name,address) values ('FEUP','Faculdade de Engenharia','Rua B, 2');
insert into degree_type (code,name) values (1,'Mestrado Integrado');
insert into degree (acronym,name,faculty,degree_type) values ('MIEEC','Mestrado Integrado','FEUP',1);
insert into student (id,degree,faculty) values (1,'MIEEC','FEUP');

select id, email = ('up' + id +'@' + faculty +'up.pt') as email, degree, faculty
from student
;
select *
    case
        when email is null then 'up' + id +'@' + faculty +'up.pt'
    end as ac
from student;