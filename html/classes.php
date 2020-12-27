<?php
  require_once ('sections/database_start.php');
  include ('sections/number_pages.php');
  $n_pages = getNumberPagesClasses();

  include ('sections/header.php');
  include ('sections/sidemenu.php');
  /*if (id == null)*/
  include ('sections/registerlogin_popups.php');
  include ('sections/sideprofile.php');
  include ('sections/pagination.php'); 
  
  $stmt = $dbh->prepare("SELECT * FROM class LIMIT ? OFFSET ?");
  $stmt -> execute(array(10, ($page - 1) * 10));  
  $class = $stmt->fetchAll();

?>
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