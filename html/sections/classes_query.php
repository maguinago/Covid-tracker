<?php 
session_start ();
$stmt = $dbh->prepare("SELECT
            person.id as person_ide,
          person.name as person_name,
         faculty.name as faculty_name,
          degree.name as degree_name,
    enrollment.course as course_acronym,
     enrollment.class as class_number
    FROM PERSON
    LEFT JOIN ENROLLMENT ON person.id = enrollment.person_id
    LEFT JOIN STUDENT ON person.id = student.id
    LEFT JOIN professor ON person.id = professor.id
    LEFT JOIN degree ON student.degree = degree.acronym
    LEFT JOIN faculty ON professor.faculty = faculty.acronym
    WHERE person_ide = ?");

    $stmt->execute(array($_SESSION["id"]));

    $class = $stmt->fetchAll();