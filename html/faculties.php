<?php
  include ('sections/ss_pdo.php');

  $stmt = $dbh->prepare("SELECT *, person.name as person_name, degree.name as degree_name FROM enrollment JOIN person ON person.id = enrollment.person_id join student ON person.id = student.id join degree ON student.degree = degree.acronym  WHERE person_id = ?");
  $stmt->execute(array($_SESSION["id"]));
  $result = $stmt->fetchAll();

  
?>


<!DOCTYPE html> 
<html>
      
  <head>
    <title>COVID-19 Tracker</title>
    <meta charset="UTF-8"/>
    <link rel="stylesheet" type="text/css" href="css/menu.css">
    <link rel="stylesheet" type="text/css" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet">   <!-- ICONES FONT AWESOME -->
    <!-- <script src="https://use.fontawesome.com/0090882658.js"></script> FONT AWESOME EM JAVASCRIPT!!! NAO USAR!!! -->
  </head>
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
    <ul class="actualtext">
    <h2>Faculdades</h2>
        <h3>Caso precise acessar outros serviços, aceda ao site específico da sua faculdade.</h3>
      <li>
        <a href="http://www.fa.up.pt/">Faculdade de Arquitetura</a>
      </li>
      <li>
        <a href="http://www.fba.up.pt/">Faculdade de Belas Artes</a>
      </li>
      <li>
        <a href="http://www.fc.up.pt/">Faculdade de Ciências</a>
      </li>
      <li>
        <a href="http://www.fcna.up.pt/">Faculdade de Ciências da Nutrição e da Alimentação</a>
      </li>
      <li>
        <a href="http://www.fade.up.pt/">Faculdade de Desporto</a>
      </li>
      <li>
        <a href="http://www.fd.up.pt/">Faculdade de Direito</a>
      </li>
      <li>
        <a href="http://www.fep.up.pt/">Faculdade de Economia</a>
      </li>
      <li>
        <a href="http://www.fe.up.pt/">Faculdade de Engenharia</a>
      </li>
      <li>
        <a href="http://www.ff.up.pt/">Faculdade de Farmácia</a>
      </li>
      <li>
        <a href="http://www.letras.up.pt/">Faculdade de Letras</a>
      </li>
      <li>
        <a href="http://www.med.up.pt/">Faculdade de Medicina</a>
      </li>
      <li>
        <a href="http://www.fmd.up.pt/">Faculdade de Medicina Dentária</a>
      </li>
      <li>
        <a href="http://www.fpce.up.pt/">Faculdade de Psicologia e Ciências da Educação</a>
      </li>
      <li>
        <a href="hhttp://www.icbas.up.pt/">Faculdade de Ciências Biomédicas</a>
      </li>
      <li>
        <a href="https://www.pbs.up.pt/">Porto Business School</a>
      </li>
    </ul>
    </div>
  </body>
</html>