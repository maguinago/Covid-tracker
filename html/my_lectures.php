<?php
session_start();
include("sections/ss_pdo.php");


include("sections/personal_query.php");

include("sections/lectures_query.php");

?>

<!DOCTYPE html> 
<html>
      
  <?php include('sections/head.php');?>

  <body>
    <!-- BARRA VERTICAL / MENU -->
    <?php include('sections/side_menu.php'); ?>
    <!-- FIM DE BARRA VERTICAL / MENU -->

<!--
    <div class="input-group margin-bottom-sm">
      <span class="input-group-addon"><i class="fa fa-envelope-o" aria-hidden="true"></i></span>
      <input class="form-control" type="text" placeholder="Email address">
    </div>
    <div class="input-group">
      <span class="input-group-addon"><i class="fa fa-key"></i></span>
      <input class="form-control" type="password" placeholder="Password">
    </div>
-->
<?php 
 include ('sections/login_personalarea.php'); ?>
 
  </ul>
  <div class="overlay_body">
  <h1>My Lectures</h1>
  <div class="overlay_body">
  <h1>My Attendances</h1>
    <ul class="overlay_body_text">
      <?php foreach ($attendance as $row) { ?>
        <li>
          <?php echo $row['start_time'] ?> | <?php echo $row["course"]?> | <?php echo $row["class_number"]?> | <?php echo $row["sala"] ?>
        </li>
      <?php } ?>
    </ul>
  </div>
    <?php } else {?>
      <div class="overlay_body">
  <h1>Você não tem permissão para aceder a este conteúdo!</h1>
      <?php } ?>
  </div>
  </body>
</html>