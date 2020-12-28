<?php


include("sections/ss_pdo.php");
$stat = $_SESSION["stat"];
unset($_SESSION["stat"]);

include("sections/personal_query.php");

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
<?php include ('sections/login_personalarea.php'); 
  if (isset($_SESSION["prof"])) { ?>
 
  </ul>
  <div class="overlay_body">
  <h1>Inserir presença manualmente</h1>
  <h3 class="subtitle">Caso um aluno não tenha registrado sua presença com o cartão U.Porto na sala de aula, insira
    sua presença submetendo este formulário.
  </h3>
    <span id="stat"><?php echo ($stat); ?></span>
      <form id="report-box" action="action_attendance.php" method="post">
        <div><div>   
                <label for="date">Data e hora da aula:</label><br>
                <input type="datetime-local" name="date" required='required'><br>
            </div>
                <label for="classroom">Sala de Aula (e.g. A101, B202):</label><br>
                <input type="text" name="classroom" placeholder="Nome exato" required='required' ><br>
            </div>
            <div>
                <label for="student_id">Estudante:</label><br>
                <input type="number" name="student_id" required='required'placeholder="Id U.Porto">
            </div>
            <div class="button">
                <input type="Submit" Value="Confirmar">
            </div>
      </div>
      </form>
    <?php } else {?>
      <div class="overlay_body">
  <h1>Você não tem permissão para aceder a este conteúdo!</h1>
      <?php } ?>
  </div>
  </body>
</html>