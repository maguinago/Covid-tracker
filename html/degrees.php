<?php
  $dbh = new PDO ('sqlite:sql/tracker.db');
  $dbh->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
  $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

  include ('sections/number_pages.php');
  $n_pages = getNumberPagesDegrees();

  include ('sections/header.php');
  include ('sections/sidemenu.php');
  /*if (id == null)*/
  include ('sections/registerlogin_popups.php');
  include ('sections/sideprofile.php');
  include ('sections/pagination.php'); 
  include ('sections/footer.php');

  $stmt = $dbh->prepare("SELECT * FROM degree LIMIT ? OFFSET ?");
  $stmt -> execute(array(10, ($page - 1) * 10));  
  $degree = $stmt->fetchAll();

?>

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