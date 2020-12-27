<?php
  $dbh = new PDO ('sqlite:sql/tracker.db');
  $dbh->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
  $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  
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