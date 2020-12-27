    <!-- BARRA VERTICAL / MENU -->
    <!-- BARRA VERTICAL / MENU -->
    <section class="sidemenu"> 
      <ul>
        <li>                                   
          <a href="home.php#login_popup">
            <i class="fa fa-home fa-lg fa-fw"></i>
            <span class="sidemenu-text">Home</span>
          </a>
        </li>
        <li>                                 
          <a href="home.html">
          <i class="fa fa-newspaper-o fa-lg fa-fw"></i>
          <span class="sidemenu-text">News</span>
          </a>
        </li>   
        <li>
          <a href="faculties.php">
          <i class="fa fa-building-o fa-lg fa-fw"></i>
          <span class="sidemenu-text">Faculdades</span>
          </a>
        </li>
        <li>
          <a href="degrees.php">
          <i class="fa fa-graduation-cap fa-lg fa-fw"></i>
          <span class="sidemenu-text">Degrees</span>
          </a>
        </li>
        <li>
          <a href="courses.php">
          <i class="fa fa-briefcase fa-lg fa-fw"></i>
          <span class="sidemenu-text">Courses</span>
          </a>
        </li>        
          
        <li>
          <a href="classes.php">
          <i class="fa fa-book fa-lg fa-fw"></i>
          <span class="sidemenu-text">Classes</span>
          </a>
        </li>   

        <li>
          <a href="home.php">
          <i class="fa fa-calendar fa-lg fa-fw"></i>
          <span class="sidemenu-text">Schedule</span>
          </a>
        </li>   

        <li>                                     
          <a href="home.php">
            <i class="fa fa-question-circle fa-lg fa-fw"></i>
            <span class="sidemenu-text">Help</span>
          </a>
        </li>   
      </ul>    
      <ul class="loginout">
        <?php if (isset ($_SESSION["id"])) { ?>
          <form action=""></form>
          <span><?php echo $_SESSION["id"]; ?></span>
          <input type="submit" value="logout">
       <?php } ?>
      </ul>
    </section>
    <!-- FIM DE BARRA VERTICAL / MENU -->