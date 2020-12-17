<!DOCTYPE html>
<html>
  <head>
    <title>Covid-Tracker | UP</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/style.css"> 
  </head>
  <body>
    <header>
        <a id="logo" href="tracker.html"><img src="images/logo.png" alt="Covid-Tracker Logo"></a>
      <form>
        <input type="text" placeholder="username" name="username">
        <input type="password" placeholder="password" name="password">
        <input type="submit" value="Login">
        <a href="#">Register</a>
      </form>
    </header>
    <div id="banner">
        <a href="https://covid19.min-saude.pt/">
            <img src="images/sns.jpg" alt="SNS 24|Banner">
        </a>    
        <p>
            Caso apresente sintomas entre em contacto com o SNS pelo 808 24 24 24 e informe a Universidade na área  
            pessoal do Portal.
        </p>
    </div>

    <section id="categories">
      <h2>Categories</h2>
      <ul>  
        <a class="item" href="tracker.html"><li>My Classes</li></a>
        <a class="item" href="tracker.html"><li>Attendance Log</li></a>
        <a class="item" href="tracker.html"><li>Personal Area</li></a>
        <a id="chart" href="tracker.html"><li>Covid in Numbers<img src="images/chart-icon.png" alt="Chart logo"></li></a>
        <!--Penso que podemos ter 4 secções da página: My Classes, Attendance Log,Personal Area.
          My classes teria informações das aulas em que está inscrito e a sala, Attendance Log a
          pessoa pode checar todas as vezes que passou seu cartão (e talvez uma área para solicitar
          que a presença seja inserida manualmente?) e se ela. 
        -->
      </ul>
    </section>
    <footer>
      <p>Guilherme Knorst Magnago & João Daniel Peixoto &copy; SIBD, 2020.</p>
    </footer>
  </body>
</html>