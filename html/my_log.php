<?php
  include("sections/ss_pdo.php");

  include("sections/personal_query.php");

  include("sections/student_log.php");
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