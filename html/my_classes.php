<?php
  $dbh = new PDO ('sqlite:sql/tracker.db');
  $dbh->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
  $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

  $stmt = $dbh->prepare("SELECT *, person.name as person_name, degree.name as degree_name FROM enrollment JOIN person ON person.id = enrollment.person_id join student ON person.id = student.id join degree ON student.degree = degree.acronym  WHERE person_id = ?");
  $stmt->execute(array($person_id=201902438));
    
  $result = $stmt->fetchAll();
?>
<!DOCTYPE html> 
<html>
      
  <head>
    <title>UP | Tracker</title>
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
          <a href="index.html">
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
          <a href="index.html">
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
        <a href="index.html">
          <span class="profile-text">> My Courses</span>
        </a>
      </li>
      <!--<hr class="dotted">-->
      <li>
        <a href="index.html">
          <span class="profile-text">> My Classes</span>
        </a>
      </li>
      <!--<hr class="dotted">-->
      <li>
        <a href="index.html">
          <span class="lastprofile-text">> My Schedule</span>
        </a>
      </li>
    </ul>

    <li>
      <span class="status-text">OK</span>
    </li>
  </ul>
  <ul id="list">
   <?php foreach ($result as $row) { ?>
    <li>
      <?php echo $row['course']?><?php echo $row['class']?>
    </li>
    <?php } ?>
  </ul>
  </body>
</html>