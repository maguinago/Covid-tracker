<?php
  $dbh = new PDO ('sqlite:sql/tracker.db');
  $dbh->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
  $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

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
      <?php echo $row['acronym']?>
    </li>
    <?php } ?>
  </ul>
</div>

<?php include ('sections/footer.php');?>
