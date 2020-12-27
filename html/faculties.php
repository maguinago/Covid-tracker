<?php
  require_once ('sections/database_start.php');
  include ('sections/number_pages.php');
  $stmt = $dbh->prepare("SELECT * FROM faculty");
  $stmt -> execute();  
  $faculty = $stmt->fetchAll();

  include ('sections/header.php');

  include ('sections/sidemenu.php');
  /*if (id == null)*/
  include ('sections/registerlogin_popups.php');
  include ('sections/sideprofile.php');
  include ('sections/pagination.php');
  include ('sections/search.php');
  include ('sections/search_function.php');

  $name = $_GET['name'];
  if(isset($name)){
    $faculty = searchForFaculty($name);
  }
?>

<div class="overlay_body">
  <h1>Faculties</h1>
    <ul class="overlay_body_list">
    <?php foreach ($faculty as $row) { ?>
    <li>
      <?php echo $row['acronym']?> - <?php echo $row['name']?>
    </li>
    <?php } ?>
  </ul>
</div>

<?php include ('sections/footer.php');?>
