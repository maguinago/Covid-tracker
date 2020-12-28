<?php if (!isset ($_SESSION["id"])) { ?>
<ul class="sideprofile"> 
   <section id="login-box">
    <span><?php  echo $msg; ?></span> <!-- Sucesso ou falha no registro -->
    <h2>Você não está logado ao sistema</h2>
      <form action="action_login.php" method="post">
        <div>   
              <label for="id">Número mecanográfico:</label><br>
              <input type="integer" placeholder="Id U.Porto" name="id"><br>
          </div>
          <div>
              <label for="password">Senha:</label><br>
              <input type="password" placeholder="Enter password" name="password"><br>
          </div>
          <div class="button">
              <input type="submit" Value="Login">
              <a href="register.php">1º Acesso</a>
          </div>
      </form>
   </section>
   </ul>
    <?php } else { if (!isset ($_SESSION["sick"])) {?>
    <ul class="sideprofile2"> <?php } else { ?> <ul class="sideprofile3">  <?php } ?>
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
      <span class="idnumber"><?php echo $_SESSION["id"] ?></span>
    </li>
    <li>
      <span class="degree-text"><?php echo $row['degree_name'] ?></span>
    </li>
    <?php } ?>
    <ul class="profile-menu">
      <li>
        <a href="my_classes.php">
          <span class="profile-text"><i class='fa fa-arrow-circle-right'></i> My Classes</span>
        </a>
      </li>
      <!--<hr class="dotted">-->
      <li>
        <a href="my_log.php">
          <span class="profile-text"><i class='fa fa-arrow-circle-right'></i> My Log</span>
        </a>
      </li>
      <!--<hr class="dotted">-->
      <li>
        <a href="report_infection.php">
          <span class="lastprofile-text"><i class='fa fa-arrow-circle-right'></i> Report Infection</span>
        </a>
      </li>
      <li>
        <p><?php echo $_SESSION["sick"];?></p>
      </li>
    </ul>
  </ul>
    <?php } ?>