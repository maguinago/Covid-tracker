<!-- SIDEPROFILE -->
<ul class="sideprofile_loginregister"> 
   <div id="login-box">
    <span><?php  echo $msg; ?></span> <!-- Sucesso ou falha no registro -->
   <h2>Você não está logado ao sistema</h2>
    <form action="action_login.php" method="post">
     
      <i class="fa fa-user-o" aria-hidden="true"></i>
          <input class="form-rl" type="text" placeholder="ID U.Porto" name="name">
          <br>
          <i class="fa fa-key"></i>
          <input class="form-rl" type="password" placeholder="Enter password" name="password">
          <input class="login-box_button" type="submit" value="Login">
          <a href="#register_popup">1º Acesso</a>
   </form>
  </ul>

