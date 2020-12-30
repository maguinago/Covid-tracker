<?php
  include("sections/ss_pdo.php");

  include("sections/personal_query.php");
  
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
<?php include ('sections/login_personalarea.php');?>

<?php include ('sections/classes_query.php'); ?>

  </ul>
  <div class="overlay_body">
  <h1>My Classes</h1>
    <ul class="actualtext">
      <?php foreach ($class as $row) { ?>
        <li>
          <h2>
          <?php echo $row['course_acronym']?><?php echo $row['class_number']?>
          </h2>
        </li>
      <?php } ?>
    </ul>
  </div>
  </body>
</html>