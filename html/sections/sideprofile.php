<?php
  $dbh = new PDO ('sqlite:sql/tracker.db');
  $dbh->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
  $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

  $stmt = $dbh->prepare("SELECT *, person.name AS person_name, degree.name as degree_name FROM enrollment JOIN person ON person.id = enrollment.person_id join student ON person.id = student.id join degree ON student.degree = degree.acronym WHERE person_id = ?");
  $stmt->execute(array($person_id=$_SESSION["id"]));
  $result = $stmt->fetchAll();

  $stmt2 = $dbh->prepare("SELECT * FROM covid WHERE person_id = ?");
  $stmt2->execute(array($person_id=$_SESSION["id"]));
  $covid_result = $stmt2->fetch();
?>

<!-- SIDEPROFILE -->
<ul class="sideprofile"> 
    <?php foreach ($result as $row) { ?>
    <li>
      <div class="profilepic">
        <img src="images/profilepics/<?php echo $row['person_id'] ?>.jpg" alt="face" width=100% height=100%>
      </div>
    </li>
    
    <li>
        <span class="username"><?php echo $row['person_name'] ?></span>
    </li>

    <li>
      <span class="idnumber"><?php echo $row['person_id'] ?></span>
    </li>

    <li>
      <span class="degree-text"><?php echo $row['degree_name'] ?></span>
    </li>
    <?php } ?>
    <ul class="profile-menu">
      <li>
        <a href="my_courses.php">
          <span class="profile-text"><i class='fa fa-arrow-circle-right'></i> My Courses</span>
        </a>
      </li>

      <li>
        <a href="my_classes.php">
          <span class="profile-text"><i class='fa fa-arrow-circle-right'></i> My Classes</span>
        </a>
      </li>
      
      <li>
        <a href="my_schedule.php">
          <span class="lastprofile-text"><i class='fa fa-arrow-circle-right'></i> My Schedule</span>
          <!-- PARA TESTAR APENAS -->
          <?php echo $covid_result[0]['result']; ?> 
        </a>
      </li>
    </ul>

    <li>
      <?php if ($covid_res == 'positive'): ?>
        <span class="status-text">RIP</span>   
      <?php elseif ($covid_res == 'negative'): ?>
        <span class="status-text">OK</span>
      <?php else: ?>
        <span class="status-text">?</span>
      <?php endif ?>
    </li>
  </ul>