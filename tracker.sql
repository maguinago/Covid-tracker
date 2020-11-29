PRAGMA foreign_keys = ON;
.headers on
.mode column

drop table if exists person;
drop table if exists student;
drop table if exists professor;
drop table if exists janitor;
drop table if exists course;
drop table if exists class;
drop table if exists campus;
drop table if exists faculty;
drop table if exists degree;
drop table if exists degree_type;
drop table if exists classroom;
drop table if exists attendance;

create table person (
    id integer primary key autoincrement,   
    name text not null,       --tag:
    tax_id integer unique,    --1 = green (no contact with known sick people)       
    address text,             --2 = yellow (indirect contact with a sick person)
    phone_number integer,     --3 = red (direct contact with a sick)
    tag varchar               --4 = black (person that tested positive)
);

create table student (
    id integer primary key references person,
    email concat ('up',id,'@',faculty,'up.pt'), --email = 'up'$id.student'@'$faculty'acronym
    degree integer unique references degree
    faculty varchar references faculty,
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

create table degree (
    acronym varchar primary key not null,
    name text not null,
    faculty references faculty
);

create table course (
    acronym varchar primary key,
    name text not null,
    degree varchar not null references degree
);

create table class (
    course_acronym varchar references course,
    number integer,
    max_students integer,
    primary key (course_acronym, number)
);

create table enrollment (
    student_id integer not null references student,
    course_acronym varchar not null references course,
    class_number integer references class,
    date datetime not null
);

create table attendance (
    student_id integer not null references student,
    course_acronym varchar references enrollment,
    class_number integer references class,
    classroom references classroom    
);