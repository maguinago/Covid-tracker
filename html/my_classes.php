<?php
  include("sections/ss_pdo.php");

  $stmt = $dbh->prepare("SELECT *, person.name as person_name, degree.name as degree_name FROM enrollment JOIN person ON person.id = enrollment.person_id join student ON person.id = student.id join degree ON student.degree = degree.acronym  WHERE person_id = ?");
  $stmt->execute(array($_SESSION["id"]));
  
  $result = $stmt->fetchAll();
?>
<!DOCTYPE html> 
<html>
      
  <head>
    <title>COVID-19 Tracker</title>
    <meta charset="UTF-8"/>
    <link rel="stylesheet" type="text/css" href="css/menu.css">
    <link rel="stylesheet" type="text/css" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet">   <!-- ICONES FONT AWESOME -->
    <!-- <script src="https://use.fontawesome.com/0090882658.js"></script> FONT AWESOME EM JAVASCRIPT!!! NAO USAR!!! -->
  </head>
  
  <body>
    <!-- BARRA VERTICAL / MENU -->
    <?php include('sections/side_menu.php'); ?>
    <!-- FIM DE BARRA VERTICAL / MENU -->

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