<?php
  require_once ('sections/ss_pdo.php');
  include ('sections/number_pages.php');
  include ('sections/head.php');
  include ('sections/side_menu.php');
  $n_pages = getNumberPagesSchedules();
  include ('sections/search.php');
  include ('sections/search_function.php');

  if(!empty($_GET['name'])){
    $name = $_GET['name'];
    $n_pages = getNumberPagesSchedulesSearch($name);
  }

  include ('sections/pagination.php');


  $stmt = $dbh->prepare("SELECT * FROM occurrence LIMIT ? OFFSET ?");
  $stmt -> execute(array(10, ($page - 1) * 10)); 
  $schedule = $stmt->fetchAll();


  if(!empty($_GET['name'])){
    $name = $_GET['name'];
    $schedule = searchForSchedule($name, $page);
  }
?>
<body>
<div class="overlay_body">
  <h1>Schedules</h1>
    <ul class="overlay_body_list">
    <?php foreach ($schedule as $row) { ?>
    <li>
      <?php echo $row['course']?><?php echo $row['class_number']?> > <?php echo $row['start_time']?> - <?php echo $row['end_time']?>
    </li>
    <?php } ?>
  </ul>
</div>

<?php include ('sections/footer.php');?>