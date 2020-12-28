<?php
  require_once ('sections/ss_pdo.php');
  include ('sections/number_pages.php');
  include ('sections/head.php');
  include ('sections/side_menu.php');
  $n_pages = getNumberPagesClasses();
  include ('sections/search.php');
  include ('sections/search_function.php');

  if(!empty($_GET['name'])){
    $name = $_GET['name'];
    $n_pages = getNumberPagesClassesSearch($name);
  }

  include ('sections/pagination.php');


  $stmt = $dbh->prepare("SELECT * FROM class LIMIT ? OFFSET ?");
  $stmt -> execute(array(10, ($page - 1) * 10)); 
  $class = $stmt->fetchAll();


  if(!empty($_GET['name'])){
    $name = $_GET['name'];
    $class = searchForClass($name, $page);
  }
?>
<body>
<div class="overlay_body">
  <h1>Classes</h1>
  <ul class="overlay_body_list">
    <?php foreach ($class as $row) { ?>
    <li>
      <?php echo $row['course']?><?php echo $row['number']?>
    </li>
    <?php } ?>
  </ul>
</div>


<?php include ('sections/footer.php'); ?>