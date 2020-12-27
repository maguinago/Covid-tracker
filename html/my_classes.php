<?php
  $dbh = new PDO ('sqlite:sql/tracker.db');
  $dbh->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
  $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);


  include ('sections/header.php');
  include ('sections/sidemenu.php');
  /*if (id == null)*/
  include ('sections/registerlogin_popups.php');
  include ('sections/sideprofile.php');

  $stmt = $dbh->prepare("SELECT *, person.name as person_name, degree.name as degree_name FROM enrollment JOIN person ON person.id = enrollment.person_id join student ON person.id = student.id join degree ON student.degree = degree.acronym  WHERE person_id = ?");
  $stmt->execute(array($person_id=201902438));
  $result = $stmt->fetchAll();
?>

<div class="overlay_body">
  <h1>My Classes</h1>
    <ul class="overlay_body_list">
    <?php foreach ($result as $row) { ?>
    <li>
      <?php echo $row['acronym']?>
    </li>
    <?php } ?>
  </ul>
</div>

<?php include ('sections/footer.php');?>
