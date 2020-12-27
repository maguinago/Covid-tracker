<?php
  $dbh = new PDO ('sqlite:sql/tracker.db');
  $dbh->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
  $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

  include ('sections/number_pages.php');
  /*GETTING THE NUMBER OF ELEMENTS/NUMBER OF PAGES*/
  $n_pages = getNumberPagesCourses();

  include ('sections/header.php');
  include ('sections/sidemenu.php');
  /*if (id == null)*/
  include ('sections/registerlogin_popups.php');
  include ('sections/sideprofile.php');
  include ('sections/pagination.php'); 
  
  $stmt = $dbh->prepare("SELECT * FROM course LIMIT ? OFFSET ?");
  $stmt -> execute(array(10, ($page - 1) * 10));  
  $course = $stmt->fetchAll();
  ?>
  
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
