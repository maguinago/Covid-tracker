<?php
  include("sections/ss_pdo.php");

  $stmt = $dbh->prepare("SELECT *, person.name as person_name, degree.name as degree_name FROM enrollment JOIN person ON person.id = enrollment.person_id join student ON person.id = student.id join degree ON student.degree = degree.acronym  WHERE person_id = ?");
  $stmt->execute(array($_SESSION["id"]));
  
  $result = $stmt->fetchAll();

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
<!DOCTYPE html> 
<html>
  <?php include('sections/head.php');?>
  <body>
    <!-- BARRA VERTICAL / MENU -->
    <?php include('sections/side_menu.php'); ?>
    <!-- FIM DE BARRA VERTICAL / MENU -->

<?php include ('sections/login_personalarea.php'); ?>

  </ul>
  <div class="textonbody">
  <h1>My Attendances</h1>
    <ul class="actualtext">
      <?php foreach ($attendance as $row) { ?>
        <li>
          <?php echo $row['start_time'] ?> | <?php echo $row["course"]?> | <?php echo $row["class_number"]?> | <?php echo $row["sala"] ?>
        </li>
      <?php } ?>
    </ul>
  </div>
  </body>
</html>