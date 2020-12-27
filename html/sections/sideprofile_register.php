<ul class="sideprofile_loginregister"> 
   <span><?php  echo $msg; ?></span> <!-- Sucesso ou falha no registro -->
    <h2>Faça seu registro</h2>
        <form action="action_register.php" method="post">        
        <i class="fa fa-user-o" aria-hidden="true"></i>
          <input class="form-rl" type="text" placeholder="Your name on sigarra" name="name">
          <br>
          <i class="fa fa-id-card-o"></i>
          <input class="form-rl" type="text" placeholder="ID U.Porto" name="id">
          <br>
          <i class="fa fa-key"></i>
          <input class="form-rl" type="password" placeholder="Password" name="password">
          <br>
          <i class="fa fa-key"></i>
          <input class="form-rl" type="password" placeholder="Confirm password" name="password2">
          <input class="login-box_button" type="submit" value="Register">

        </form>
        <a href="#login_popup" class="loginregister_button">Login</a>
  </ul>
