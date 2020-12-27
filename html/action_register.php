<?php
    session_start();
    $msg = $_SESSION["msg"];
    unset($_SESSION["msg"]);

    $dbh = new PDO ('sqlite:sql/tracker.db');
    $dbh->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    

    $name = $_POST['name'];
    $id = $_POST['id'];
    $password = $_POST['password'];
    $password2 = $_POST['password2'];

    #insert new user into database
    function insertUser($name,$id,$password) {
        global $dbh;
        global $con;
        $stmt = $dbh->prepare("INSERT INTO user (name,id,password) VALUES (?,?,?)");
        $stmt->execute(array($name,$id,hash('sha256',$password)));
    }

    if (strlen($id) < 6) {
        $_SESSION["msg"] = "ID Inválido.";
        header ('Location: register.php');
        die();
    }

    if (strlen($password) < 8) {
        $_SESSION["msg"] = "A senha é muito curta.";
        header ('Location: register.php');
        die();
    }

    if ($password <> $password2) {
        $_SESSION["msg"] = "As senhas não coincidem.";
        header ('Location: register.php');
        die();
    }

    try {
    insertUser ($name,$id,hash('sha256',$password));
    $_SESSION["msg"] = "Bem vindo(a)!";
    header('Location: index.php');
    } catch (PDOException $e) {
        $err_msg = $e->getMessage();
        if (strpos($err_msg, "UNIQUE")) {
            $_SESSION["msg"] = "ID já registrado, faça login!";
        } else {
            $_SESSION ["msg"] = "O registro falhou :(";
        }
        header('Location: register.php');
    }
?>