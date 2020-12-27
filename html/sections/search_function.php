<?php

function searchForFaculty($name){
    global $dbh;
    $stmt = $dbh->prepare("SELECT * FROM faculty WHERE name LIKE ?");
    $stmt -> execute(array("%$name%"));  
    return $stmt->fetchAll();
}


?>