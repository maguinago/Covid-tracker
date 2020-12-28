<?php

function searchForCourse($name, $page){
    global $dbh;
    $stmt = $dbh->prepare("SELECT * FROM course WHERE acronym LIKE ? LIMIT ? OFFSET ?");
    $stmt -> execute(array("%$name%", 10, ($page - 1) * 10));  
    return $stmt->fetchAll();
}

function searchForClass($name, $page){
    global $dbh;
    $stmt = $dbh->prepare("SELECT * FROM class WHERE course LIKE ? LIMIT ? OFFSET ?");
    $stmt -> execute(array("%$name%", 10, ($page - 1) * 10));  
    return $stmt->fetchAll();
}

function searchForFaculty($name, $page){
    global $dbh;
    $stmt = $dbh->prepare("SELECT * FROM faculty WHERE acronym LIKE ? OR name LIKE ? LIMIT ? OFFSET ?");
    $stmt -> execute(array("%$name%","%$name%", 10, ($page - 1) * 10));  
    return $stmt->fetchAll();
}

function searchForDegree($name, $page){
    global $dbh;
    $stmt = $dbh->prepare("SELECT * FROM degree WHERE acronym LIKE ? LIMIT ? OFFSET ?");
    $stmt -> execute(array("%$name%", 10, ($page - 1) * 10));  
    return $stmt->fetchAll();
}

function searchForSchedule($name, $page){
    global $dbh;
    $stmt = $dbh->prepare("SELECT * FROM occurrence WHERE course LIKE ? LIMIT ? OFFSET ?");
    $stmt -> execute(array("%$name%", 10, ($page - 1) * 10));  
    return $stmt->fetchAll();
}
?>