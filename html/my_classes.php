<?php
  include("sections/ss_pdo.php");

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
  <h1>My Classes</h1>
    <ul class="actualtext">
      <?php foreach ($result as $row) { ?>
        <li>
          <h2>
          <?php echo $row['course']?><?php echo $row['class']?>
          </h2>
        </li>
      <?php } ?>
    </ul>
  </div>
  </body>
</html>