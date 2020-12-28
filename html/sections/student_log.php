<?php
$stmt3 = $dbh->prepare(
"SELECT *, attendance.classroom as sala
  FROM attendance
  JOIN occurrence 
    ON attendance.swipe
BETWEEN occurrence.start_time
   AND occurrence.end_time
   AND sala = occurrence.classroom
 WHERE person_id = ?
 ORDER BY start_time DESC");
  $stmt3->execute(array($_SESSION["id"]));
  $attendance = $stmt3->fetchAll();
?>