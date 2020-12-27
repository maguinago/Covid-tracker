<?php
    session_start();
    $msg = $_SESSION["msg"];
    unset($_SESSION["msg"]);
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
    <section class="sidemenu"> 
      <ul>

        <li>                                   
          <a href="index.php">
            <i class="fa fa-home fa-lg fa-fw"></i>
            <span class="sidemenu-text">Home</span>
          </a>
        </li>   
            
        <li>                                 
          <a href="index.html">
          <i class="fa fa-newspaper-o fa-lg fa-fw"></i>
          <span class="sidemenu-text">News</span>
          </a>
        </li>   
          
        <li>
          <a href="faculties.php">
          <i class="fa fa-building-o fa-lg fa-fw"></i>
          <span class="sidemenu-text">Faculties</span>
          </a>
        </li>
          
        <li>
          <a href="index.html">
          <i class="fa fa-graduation-cap fa-lg fa-fw"></i>
          <span class="sidemenu-text">Degrees</span>
          </a>
        </li>
          
        <li>
          <a href="index.html">
          <i class="fa fa-briefcase fa-lg fa-fw"></i>
          <span class="sidemenu-text">Courses</span>
          </a>
        </li>        
          
        <li>
          <a href="index.html">
          <i class="fa fa-book fa-lg fa-fw"></i>
          <span class="sidemenu-text">Classes</span>
          </a>
        </li>   

        <li>
          <a href="index.html">
          <i class="fa fa-calendar fa-lg fa-fw"></i>
          <span class="sidemenu-text">Schedule</span>
          </a>
        </li>   

        <li>                                     
          <a href="index.html">
            <i class="fa fa-question-circle fa-lg fa-fw"></i>
            <span class="sidemenu-text">Help</span>
          </a>
        </li>   
      </ul>    
      <ul class="loginout">
        <li>                                 
          <a href="index.html">
          <i class="fa fa-user fa-lg fa-fw"></i>
          <span class="sidemenu-text">Register</span>
          </a>
        </li>  
        <li>
          <a href="index.html">
            <i class="fa fa-sign-in fa-lg fa-fw"></i>
            <span class="sidemenu-text">Login</span>
          </a>
        </li>

      </ul>
    </section>
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
  <ul class="sideprofile"> 
   <section id="login-box">
   <span><?php  echo $msg; ?></span> <!-- Sucesso ou falha no registro -->
    <h2>Faça seu registro</h2>
        <form action="action_register.php" method="post">
            <div>
                <label for="name">Nome completo:</label><br>
                <input type="text" placeholder="Conforme no sigarra" name="name"><br>
            </div>
            <div>
                <label for="id">Número mecanográfico:</label><br>
                <input type="number" placeholder="Id U.Porto" name="id"><br>
            </div>
            <div>
                <label for="id">Criar senha:</label><br>
                <input type="password" placeholder="Enter password" name="password"><br>
            </div>
            <div>
                <label for="id">Confirmar senha:</label><br>
                <input type="password" placeholder="Reenter password" name="password2"><br>
            </div>
            <div class="button">
                <input type="submit" Value="Registrar-se">
                <a href="index.php">Login</a>
            </div>
        </form>
    </section>
  </ul>
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