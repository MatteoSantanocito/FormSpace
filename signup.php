<?php
    include_once 'dbconfig.php';

    session_start();
    if(isset($_SESSION["username"])){
        header("Location: profile.php");
        exit;
    }

    if(isset($_POST["name"]) && isset($_POST["lastname"]) && isset($_POST["email"]) && isset($_POST["username"]) && isset($_POST["password"])){

        $error = array();

        $conn = mysqli_connect($dbconfig["host"], $dbconfig["user"], $dbconfig["password"], $dbconfig["name"]) or die("Errore: ".mysqli_connect_error());
        $name = mysqli_real_escape_string($conn, $_POST["name"]);
        $lastname = mysqli_real_escape_string($conn, $_POST["lastname"]);
        $email = mysqli_real_escape_string($conn, strtolower($_POST["email"]));
        $username = mysqli_real_escape_string($conn, $_POST["username"]);
        $password = mysqli_real_escape_string($conn, $_POST["password"]);


        if(!preg_match('/^[a-zA-Z0-9_]{1,15}$/', $username)) {
            $error[] = "Username non valido";
        } else {
            $query = "SELECT username FROM users WHERE username = '$username'";
            $res = mysqli_query($conn, $query);
            if (mysqli_num_rows($res) > 0) {
                $error[] = "Username già utilizzato";
            }
        }

        if(strlen($password) < 8) {
            $error[] = "Password troppo corta";
        }

        if(strlen($name) == 0) {
            $error[] = "Nome non valido";
        }

        if(strlen($lastname) == 0) {
            $error[] = "Cognome non valido";
        }

        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $error[] = "Email non valida";
        } else {
            $res = mysqli_query($conn, "SELECT email FROM users WHERE email = '$email'");
            if (mysqli_num_rows($res) > 0) {
                $error[] = "Email già utilizzata";
            }
        }

        if(count($error) == 0) {
            $query = "INSERT INTO users(name, lastname, email, username, password) VALUES('$name', '$lastname', '$email', '$username', '$password')";
            if(mysqli_query($conn, $query)) {
                header("Location: login.php");
            } else {
                $error[] = "Errore di connessione al server";
            }
        }


    }
?>
<html>
    <head>
        <title>Signup - FormSpace</title>
        <link rel="stylesheet" href="./styles/signup.css">
        <meta name = "viewport" content = "width=device-width, initial-scale=1.0">
        <script src="./scripts/signup.js" defer></script>
    </head>
    <body>
        <article>
            <main>
                <form method="post" name="signup_form" autocomplete="off">
                    <h1>Registrati</h1>
                    <input type="text" name="name" placeholder="Nome" class="box">
                    <input type="text" name="lastname" placeholder="Cognome" class="box">
                    <input type="text" name="username" placeholder="Username" class="box">
                    <input type="text" name="email" placeholder="Email" class="box">
                    <input type="password" name="password" placeholder="Password" class="box">
                    <input id="signup_button" type="submit" value="Registrati" class="btn">
                    <p> Hai già un account? <a href = "login.php"> Login</a></p>
                </form>
            </main>
        </article>
    </body>
</html>
