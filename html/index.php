<?php
  include ('sections/ss_pdo.php');

  $msg = $_SESSION["msg"];
  unset($_SESSION["msg"]);

 
?>

<!DOCTYPE html> 
<html>
      
  <?php include('sections/head.php');
    include("sections/personal_query.php")
    ?>
  
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