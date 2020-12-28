<?php
    session_start ();
    include ('sections/ss_pdo.php');
    
    # access parameters from registration request
    $student_id = $_POST['student_id'];
    $date = $_POST['date'];
    $classroom = $_POST['classroom'];

    #verify id and password
    function insertAttendance ($student_id,$date,$classroom) {
        global $dbh;
        $stmt = $dbh->prepare("INSERT INTO attendance (id,person_id,swipe,classroom) VALUES (?,?,?,?)");
        $stmt->execute(array(NULL,$student_id,$date,$classroom));
    }
   
    insertAttendance ($student_id,$date,$classroom);
    $_SESSION["stat"] = "Confirmação submetida!";
    header('Location: attendance_insert.php');

?>