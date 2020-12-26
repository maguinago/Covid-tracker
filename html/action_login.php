<?php
    $dbh = new PDO ('sqlite:sql/tracker.db');
    $dbh->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    # access parameters from registration request
    $name = $_POST['name'];
    $id = $_POST['id'];
    $password = $_POST['password'];

    #verify id and password
    function loginIsValid ($id,$password) {
        global $dbh;
        $stmt = $dbh->prepare("SELECT id FROM users WHERE id=? AND password=?");
        $stmt->execute(array($id,hash('sha256',$password)));
        return $stmt-> fetch();
    }

    #if login successfull
    # - create a session attribute for user id
    # - redirect for home page if
    #else
    # - remain in login page and show error message

?>