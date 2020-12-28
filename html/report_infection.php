<?php
  include("sections/ss_pdo.php");
  $stat = $_SESSION["stat"];
  unset($_SESSION["stat"]);

  $stmt = $dbh->prepare("SELECT *, person.name as person_name, degree.name as degree_name FROM enrollment JOIN person ON person.id = enrollment.person_id join student ON person.id = student.id join degree ON student.degree = degree.acronym  WHERE person_id = ?");
  $stmt->execute(array($_SESSION["id"]));
  
  $result = $stmt->fetchAll();

  $stmt3 = $dbh->prepare(
"SELECT *, attendance.classroom as sala
  FROM attendance
  JOIN occurrence 
    ON attendance.swipe
BETWEEN occurrence.start_time
   AND occurrence.end_time
   AND sala = occurrence.classroom
 WHERE person_id = ?
 ORDER BY start_time DESC");
  $stmt3->execute(array($_SESSION["id"]));
  $attendance = $stmt3->fetchAll();

?>
<!DOCTYPE html> 
<html>
      
  <?php include('sections/head.php');?>

  <body>
    <!-- BARRA VERTICAL / MENU -->
    <?php include('sections/side_menu.php'); ?>
    <!-- FIM DE BARRA VERTICAL / MENU -->

<!--
    <div class="input-group margin-bottom-sm">
      <span class="input-group-addon"><i class="fa fa-envelope-o" aria-hidden="true"></i></span>
      <input class="form-control" type="text" placeholder="Email address">
    </div>
    <div class="input-group">
      <span class="input-group-addon"><i class="fa fa-key"></i></span>
      <input class="form-control" type="password" placeholder="Password">
    </div>
-->
<?php include ('sections/login_personalarea.php'); ?>

  </ul>
  <div class="textonbody">
  <h1>Reportar infecção para COVID-19</h1>
  <h3>Caso tenha testado positivo para o Covid-19, preencha o formulário abaixo.
      Lembramos que a inserção de informações falsas levarão à investigação e possível
      sanção dos responsáveis.
  </h3>
  <span id="stat"><?php echo ($stat); ?></span>
    <form id="report-box" action="action_infection.php" method="post">
        <div>   
              <label for="id">Data do teste:</label><br>
              <input type="date" name="date"><br>
          </div>
          <div id="aware">
              <div><input type="checkbox" name="aware" required='required'></div>
              <div><label for="aware"><p>Estou ciente da minha responsabilidade quanto à informação aqui submetida.</p></label></div>
          </div>
          <div class="button">
              <input type="Submit" Value="Confirmar">
          </div>
    </form>
  </div>
  </body>
</html>