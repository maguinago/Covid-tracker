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

<?php include ('sections/login_personalarea.php'); ?>

  </ul>
  <div class="overlay_body">
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