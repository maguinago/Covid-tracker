<?php
    session_start();
    $msg = $_SESSION["stat"];
    unset($_SESSION["stat"]);

    include("sections/ss_pdo.php");

    $date = $_POST['date'];
    $id = $_SESSION['id'];
    
    #insert new user into database
    function reportInfection($date,$id) {
        global $dbh;
        $stmt = $dbh->prepare("INSERT INTO covid (id,person_id,result,date) VALUES (?,?,?,?)");
        $stmt->execute(array(NULL,$id,'positive',$date));
    }

    reportInfection ($date,$id);
    $_SESSION["stat"] = "Confirmação submetida!";
    header('Location: report_infection.php');
?>