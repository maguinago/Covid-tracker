<?php
session_start();
$_SESSION["prof"] =$prof;

$stmt5 = $dbh->prepare(
"SELECT *, attendance.classroom as sala, 
person.name as person_name, 
  person.id as person_ide,
occurrence.start_time as time
FROM occurrence
JOIN attendance ON attendance.swipe BETWEEN occurrence.start_time AND occurrence.end_time AND sala = occurrence.classroom
JOIN person ON person_id = person.id
WHERE occurrence.professor = ?
AND occurrence.classroom IS NOT 'EAD'
AND attendance.person_id <> ?
AND occurrence.end_time < datetime('now')"
);

 $stmt5->execute(array($prof,$prof));
 $lecture = $stmt5->fetchAll();
?>