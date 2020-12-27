<?php

function searchForFaculty($name){
    global $dbh;
    $stmt = $dbh->prepare("SELECT * FROM faculty WHERE acronym LIKE ? OR name LIKE ? OR address LIKE ?");
    $stmt -> execute(array("%$name%","%$name%","%$name%"));  
    return $stmt->fetchAll();
}
?>