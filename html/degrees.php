<?php
  require_once ('sections/ss_pdo.php');
  include ('sections/number_pages.php');
  include ('sections/head.php');
  include ('sections/side_menu.php');
  $n_pages = getNumberPagesDegrees();
  include ('sections/search.php');
  include ('sections/search_function.php');

  if(!empty($_GET['name'])){
    $name = $_GET['name'];
    $n_pages = getNumberPagesDegreesSearch($name);
  }

  include ('sections/pagination.php');


  $stmt = $dbh->prepare("SELECT * FROM degree LIMIT ? OFFSET ?");
  $stmt -> execute(array(10, ($page - 1) * 10)); 
  $degree = $stmt->fetchAll();


  if(!empty($_GET['name'])){
    $name = $_GET['name'];
    $degree = searchForDegree($name, $page);
  }
?>
<body>
<div class="overlay_body">
  <h1>Degrees</h1>
    <ul class="overlay_body_list">
   <?php foreach ($degree as $row) { ?>
    <li>
      <?php echo $row['degree_type']?> <?php echo $row['faculty.acronym']?> <?php echo $row['acronym']?> <?php echo $row['name']?>
    </li>
    <?php } ?>
  </ul>
</div>
  <?php
  include ('sections/footer.php');?>