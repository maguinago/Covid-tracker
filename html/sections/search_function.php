<?php

function searchForFaculty($name){
    global $dbh;
    $stmt = $dbh->prepare("SELECT * FROM faculty WHERE acronym LIKE ? OR name LIKE ?");
    $stmt -> execute(array("%$name%","%$name%"));  
    return $stmt->fetchAll();
}

function searchForSchedule($name){
    global $dbh;
    $stmt = $dbh->prepare("SELECT * FROM occurrence WHERE course LIKE ? LIMIT ? OFFSET ?");
    $stmt -> execute(array("%$name%", 10, ($page - 1) * 10));  
    return $stmt->fetchAll();
}

?>