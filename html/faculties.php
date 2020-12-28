<?php
require_once ('sections/ss_pdo.php');
//include ('sections/number_pages.php');
include ('sections/head.php');
include ('sections/side_menu.php');
/*
$n_pages = getNumberPagesFaculties();
include ('sections/search.php');
include ('sections/search_function.php');

if(!empty($_GET['name'])){
  $name = $_GET['name'];
  $n_pages = getNumberPagesFacultiesSearch($name);
}

include ('sections/pagination.php');


$stmt = $dbh->prepare("SELECT * FROM faculty LIMIT ? OFFSET ?");
$stmt -> execute(array(10, ($page - 1) * 10)); 
$faculty = $stmt->fetchAll();


if(!empty($_GET['name'])){
  $name = $_GET['name'];
  $faculty = searchForFaculty($name, $page);
}*/
?>

<!--<body>
<div class="overlay_body">
  <h1>Faculties</h1>
    <ul class="overlay_body_list">
    <?php /*foreach ($faculty as $row) { */?>
    <li>
      <?php /*echo $row['acronym']?> - <?php echo $row['name'] */?>
    </li>
    <?php /*}*/ ?>
  </ul>
</div> -->

<!DOCTYPE html> 
<html>
      
<?php include('sections/head.php');?>

  <body>
    <!-- BARRA VERTICAL / MENU -->
  <?php include('sections/side_menu.php'); ?>

  <div class="overlay_body">
  <h1>Faculdades</h1>
    <ul class="overlay_body_list">
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
<?php include ('sections/footer.php');?>
