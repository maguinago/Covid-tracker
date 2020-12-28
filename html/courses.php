<?php
  require_once ('sections/ss_pdo.php');
  include ('sections/number_pages.php');
  include ('sections/head.php');
  include ('sections/side_menu.php');
  $n_pages = getNumberPagesCourses();
  include ('sections/search.php');
  include ('sections/search_function.php');

  if(!empty($_GET['name'])){
    $name = $_GET['name'];
    $n_pages = getNumberPagesCoursesSearch($name);
  }

  include ('sections/pagination.php');


  $stmt = $dbh->prepare("SELECT * FROM course LIMIT ? OFFSET ?");
  $stmt -> execute(array(10, ($page - 1) * 10)); 
  $course = $stmt->fetchAll();


  if(!empty($_GET['name'])){
    $name = $_GET['name'];
    $course = searchForCourse($name, $page);
  }
?>
  <body>
<div class="overlay_body">
  <h1>Courses</h1>
    <ul class="overlay_body_list">
    <?php foreach ($course as $row) { ?>
    <li>
      <?php echo $row['acronym']?> - <?php echo $row['name']?> - <?php echo $row['degree']?>
    </li>
    <?php } ?>
  </ul>
</div>

<?php include ('sections/footer.php'); ?>
