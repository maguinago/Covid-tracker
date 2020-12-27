<?php
  require_once ('sections/database_start.php');
  include ('sections/number_pages.php');
  $n_pages = getNumberPagesSchedules();

  include ('sections/header.php');

  include ('sections/sidemenu.php');
  /*if (id == null)*/
  include ('sections/registerlogin_popups.php');
  include ('sections/sideprofile.php');
  include ('sections/pagination.php');

  $stmt = $dbh->prepare("SELECT * FROM occurrence LIMIT ? OFFSET ?");
  $stmt -> execute(array(10, ($page - 1) * 10)); 
  $schedule = $stmt->fetchAll();

  $name = $_GET['name'];
  if(isset($name)){
    $schedule = searchForSchedule($name);
  }
?>

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