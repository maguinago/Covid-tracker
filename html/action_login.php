<?php
    session_start ();
    unset($_SESSION["sick"]);

    $dbh = new PDO ('sqlite:sql/tracker.db');
    $dbh->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    # access parameters from registration request
    $id = $_POST['id'];
    $password = $_POST['password'];

    #verify id and password
    function loginIsValid ($id,$password) {
        global $dbh;
        $stmt = $dbh->prepare('SELECT id FROM user WHERE id=? AND password=?');
        $stmt->execute(array($id,hash('sha256','$password')));
        return $stmt-> fetch();
    }
   
    #if login successfull
    # - create a session attribute for user id
    # - redirect for home page if
    #else
    # - remain in login page and show error message
    if (loginIsValid($id, $password)) {
        $_SESSION["id"] = $id;
        if (userIsProfessor($id)){
            $_SESSION["prof"]=$id;
        } 
    } else {
        $_SESSION["msg"] = "Falha no login!";
    }

    #verify if the user is a professor
    function userIsProfessor($id) {
        global $dbh;
        $stmt4 = $dbh->prepare('SELECT id FROM professor WHERE id=?');
        $stmt4->execute(array($id));
        return $stmt4->fetch();
    }
    
    #if person logging in contacted a sick person
    #- create a session attribute for sick contact
    #else
    #- do nothing
    function contactedSickPerson ($id) {
        global $dbh;
        $stmt2 = $dbh->prepare("SELECT * FROM
        (SELECT DISTINCT attendance.person_id as notify_covid_contact
            FROM attendance --(4)return attendances (id) within those times and in those
            JOIN            --classrooms (meaning same class), except who tested positive,
                (           --to be notified as a contact and isolate + contact SNS
                SELECT *           --(3)join all occurrences to the ones where someone that has
                FROM occurrence     --been confirmed infected was present. This way, you have the
                JOIN                --start and end times for classes with infected people.
                    (
                    SELECT *, classroom as sala           --(2)all attendances of people that tested positive in the 10
                    FROM attendance      --days prior to their covid exam
                    JOIN
                        (
                        SELECT *          --(1)returns everyone who tested positive
                        FROM covid
                        WHERE covid.result = 'positive'
                        )--(1)
                    USING (person_id)
                    JOIN covid USING (person_id) 
                    WHERE attendance.swipe BETWEEN date(covid.date , '-10 days') AND covid.date
                    ) --(2)
                ON swipe BETWEEN occurrence.start_time AND occurrence.end_time AND sala = occurrence.classroom
                ) --(3)
            ON attendance.swipe BETWEEN occurrence.start_time AND occurrence.end_time
        JOIN occurrence
        ON attendance.classroom = occurrence.classroom
        LEFT JOIN covid USING (person_id)
        WHERE covid.result IS NOT 'positive'
        ) WHERE notify_covid_contact=?");
        $stmt2->execute(array($id));
        return $stmt2-> fetch();
    }   


    if (contactedSickPerson($id)) {
        $_SESSION["sick"] = "Estivestes em contacto com um infetado. Contacte o SNS!";
      } else {
        $_SESSION["dead"] = "Use máscara e álcool gel!";
      }
header('Location: index.php');
?>