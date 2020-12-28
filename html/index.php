<?php
  include ('sections/ss_pdo.php');

  $msg = $_SESSION["msg"];
  unset($_SESSION["msg"]);

  $stmt = $dbh->prepare("SELECT *, person.name as person_name, degree.name as degree_name FROM enrollment JOIN person ON person.id = enrollment.person_id join student ON person.id = student.id join degree ON student.degree = degree.acronym  WHERE person_id = ?");
  $stmt->execute(array($_SESSION["id"]));
  $result = $stmt->fetchAll();
?>

<!DOCTYPE html> 
<html>
      
  <?php include('sections/head.php');?>
  
  <body>
    <!-- BARRA VERTICAL / MENU -->
  <?php include('sections/side_menu.php'); ?>
    <!-- FIM DE BARRA VERTICAL / MENU -->

<?php include ('sections/login_personalarea.php'); ?>
  <div class="overlay_body">
    <div class="overlay_body_list">
     <img src="images/covid-tracker.png" alt="Big covid logo" height="500em" class="logo">
</div>
  </body>
</html>