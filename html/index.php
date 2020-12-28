<?php
  include ('sections/ss_pdo.php');

      $msg = $_SESSION["msg"];
    unset($_SESSION["msg"]);

  $stmt = $dbh->prepare("SELECT *, person.name as person_name, degree.name as degree_name FROM enrollment JOIN person ON person.id = enrollment.person_id join student ON person.id = student.id join degree ON student.degree = degree.acronym  WHERE person_id = ?");
  $stmt->execute(array($_SESSION["id"]));
  $result = $stmt->fetchAll();
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
  <div class="textonbody">
    <h1>COVID-19 Tracker</h1>
    <ul class="actualtext">
      <li>
        <h2>O que é o Covid-19</h2>
        <p>Os coronavírus pertencem à família Coronaviridae que integra vírus que podem causar infeção no 
          Homem, noutros mamíferos (por exemplo nos morcegos, camelos, civetas) e nas aves. Até à data, 
          conhecemos oito coronavírus que infetam e podem causar doença no Homem. Normalmente, estas 
          infeções afetam o sistema respiratório, podendo ser semelhantes às constipações comuns ou 
          evoluir para uma doença mais grave, como a pneumonia. Dos coronavírus que infetam o Homem o 
          SARS-CoV, o MERS-CoV e o SARS-CoV-2 saltaram a barreira das espécies, ou seja, estes vírus 
          foram transmitidos ao Homem a partir de um animal reservatório ou hospedeiro desses vírus. 
          O SARS-CoV originou uma epidemia em 2002-2003 e o MERS-CoV emergiu em 2012 e foi causando 
          casos esporádicos de infeção humana ou pequenos clusters de casos de doença respiratória. 
          O novo coronavírus, o SARS-CoV-2, que origina a doença designada COVID-19, foi identificado 
          pela primeira vez em dezembro de 2019, na China. <br>
          (Fonte: <a href="https://covid19.min-saude.pt/category/perguntas-frequentes/">https://covid19.min-saude.pt/category/perguntas-frequentes/ )</a>
        </p>
      </li>
      <li>
        <h2>Como funciona o tracker da Universidade do Porto</h2>
        <p>Todos membros da comunidade devem usar seus cartões ao atender uma atividade letiva. Ao passar o
          cartão no leitor disponível, a sua presença fica registrada naquela atividade. Caso um membro da
          comunidade venha a testar positivo para o SARS-CoV-2, todas pessoas que estiveram em contacto
          consigo recentemente receberão uma notificação neste portal. Por este motivo, pedimos a colaboração
          de todos para que estejam alertas a possíveis sintomas e para que comuniquem o mais brevemente
          possível caso teste positivo para o Corona Vírus.
        </p>
      </li>
    </ul>
  </body>
</html>