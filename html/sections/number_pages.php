<?php
function getNumberPagesCourses(){
    global $dbh;
    $stmt = $dbh->prepare("SELECT COUNT(*) FROM course");
    $stmt -> execute();  
    $n_elem =  $stmt->fetchColumn();
    return $n_pages = ceil($n_elem / 10);
}

function getNumberPagesClasses(){
    global $dbh;
    $stmt = $dbh->prepare("SELECT COUNT(*) FROM class");
    $stmt -> execute();  
    $n_elem =  $stmt->fetchColumn();
    return $n_pages = ceil($n_elem / 10);
}

function getNumberPagesFaculties(){
    global $dbh;
    $stmt = $dbh->prepare("SELECT COUNT(*) FROM faculty");
    $stmt -> execute();  
    $n_elem =  $stmt->fetchColumn();
    return $n_pages = ceil($n_elem / 10);
}

function getNumberPagesDegrees(){
    global $dbh;
    $stmt = $dbh->prepare("SELECT COUNT(*) FROM degree");
    $stmt -> execute();  
    $n_elem =  $stmt->fetchColumn();
    return $n_pages = ceil($n_elem / 10);
}

function getNumberPagesSchedules(){
    global $dbh;
    $stmt = $dbh->prepare("SELECT COUNT(*) FROM occurrence");
    $stmt -> execute();  
    $n_elem =  $stmt->fetchColumn();
    return $n_pages = ceil($n_elem / 10);
}

function getNumberPagesCoursesSearch($name){
    global $dbh;
    $stmt = $dbh->prepare("SELECT COUNT(*) FROM course WHERE acronym LIKE ?");
    $stmt -> execute(array("%$name%"));
    $n_elem =  $stmt->fetchColumn();
    return $n_pages = ceil($n_elem / 10);
}

function getNumberPagesClassesSearch($name){
    global $dbh;
    $stmt = $dbh->prepare("SELECT COUNT(*) FROM class WHERE course LIKE ?");
    $stmt -> execute(array("%$name%"));
    $n_elem =  $stmt->fetchColumn();
    return $n_pages = ceil($n_elem / 10);
}

function getNumberPagesFacultiesSearch($name){
    global $dbh;
    $stmt = $dbh->prepare("SELECT COUNT(*) FROM faculty WHERE acronym LIKE ?");
    $stmt -> execute(array("%$name%"));
    $n_elem =  $stmt->fetchColumn();
    return $n_pages = ceil($n_elem / 10);
}

function getNumberPagesDegreesSearch($name){
    global $dbh;
    $stmt = $dbh->prepare("SELECT COUNT(*) FROM degree WHERE acronym LIKE ?");
    $stmt -> execute(array("%$name%"));
    $n_elem =  $stmt->fetchColumn();
    return $n_pages = ceil($n_elem / 10);
}

function getNumberPagesSchedulesSearch($name){
    global $dbh;
    $stmt = $dbh->prepare("SELECT COUNT(*) FROM occurrence WHERE course LIKE ?");
    $stmt -> execute(array("%$name%"));
    $n_elem =  $stmt->fetchColumn();
    return $n_pages = ceil($n_elem / 10);
}

/*
function getNumberPagesMyCourses(){
    global $dbh;
    $stmt = $dbh->prepare("SELECT COUNT(*) FROM course");
    $stmt -> execute();  
    $n_elem =  $stmt->fetchColumn();
    return $n_pages = ceil($n_elem / 10);
}

function getNumberPagesMyClasses(){
    global $dbh;
    $stmt = $dbh->prepare("SELECT COUNT(*) FROM course");
    $stmt -> execute();  
    $n_elem =  $stmt->fetchColumn();
    return $n_pages = ceil($n_elem / 10);
}*/
?>
