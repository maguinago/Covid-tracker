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

create table person (
    id integer primary key autoincrement,
    name text not null 
);
create table student (
    id integer primary key references person autoincrement,
    name text not null,
    phone integer,
    tax_id integer unique,
    email varchar,
    address text,
    tag text,
    degree_code integer unique references degree
);

create table professor (
    id integer 
)

create table course (

);

create table class (

);

create table campus (

);

create table faculty (

);

create table degree (

);