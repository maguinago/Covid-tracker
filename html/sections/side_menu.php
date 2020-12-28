<section class="sidemenu"> 
      <ul>
        <li>                                   
          <a href="index.php">
            <i class="fa fa-home fa-lg fa-fw"></i>
            <span class="sidemenu-text">Home</span>
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
          <a href="schedule.php">
          <i class="fa fa-calendar fa-lg fa-fw"></i>
          <span class="sidemenu-text">Schedule</span>
          </a>
        </li>   

        <li>                                     
          <a href="help.php">
            <i class="fa fa-question-circle fa-lg fa-fw"></i>
            <span class="sidemenu-text">Help</span>
          </a>
        </li>   
      </ul>    
      <ul class="loginout">
        <?php if (!isset ($_SESSION["id"])) { ?>
        <li>                                 
          <a href="register.php">
          <i class="fa fa-user fa-lg fa-fw"></i>
          <span class="sidemenu-text">Register</span>
          </a>
        </li>  
        <li>
          <a href="index.php">
            <i class="fa fa-sign-in fa-lg fa-fw"></i>
            <span class="sidemenu-text">Login</span>
          </a>
        </li>
        <?php } else { ?>
          <li>
          <a href="action_logout.php">
            <i class="fa fa-sign-out fa-lg fa-fw"></i>
            <span class="sidemenu-text">Logout</span>
          </a>
        </li>
       <?php } ?>
      </ul>
    </section>