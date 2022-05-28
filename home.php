<?php

    include_once 'dbconfig.php';

    session_start();
    if(!isset($_SESSION["username"])){
        header("Location: login.php");
        exit;
    }
    else {
        $conn = mysqli_connect($dbconfig["host"], $dbconfig["user"], $dbconfig["password"], $dbconfig["name"]) or die("Errore: ".mysqli_connect_error());
        $query = "SELECT name, lastname, email FROM users WHERE username='".$_SESSION["username"]."'";
        $res = mysqli_query($conn, $query);
        if(mysqli_num_rows($res) > 0) {
            $row = mysqli_fetch_assoc($res);
            $name = $row["name"];
            $lastname = $row["lastname"];
            $email = $row["email"];
        }
    }
?>
<!DOCTYPE html>
<html>
    <head>
        <title>Home - FormSpace</title>

        <link rel="stylesheet" href="./styles/home.css">
        <link rel="stylesheet" href="./styles/spotify.css">

        <meta name = "viewport" content = "width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v2.1.6/css/unicons.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <script src="./scripts/home.js" defer></script>
        <script src="./scripts/profile.js" defer></script>
        <script src="./scripts/spotify.js" defer></script>
    </head>
    <body>
        <header>
          <div class="container">
            <div id="logo">
                <p>FormSpace</p>
            </div>

            <div id="profile" data-username=<?php echo $_SESSION["username"]; ?>>
                <div>
                    <?php
                        echo $name[0].$lastname[0];
                    ?>
                </div>
                <p>
                    <?php
                        echo $name." ".$lastname;
                    ?>
                </p>
            </div>
            <div id="profile_info" class="hidden">
            <div>
                <h1>
                    <?php
                        echo $name[0].$lastname[0];
                    ?>
                </h1>
                <h2>
                    <?php
                        echo $_SESSION["username"];
                    ?>
                </h2>
                <h3><?php echo $email?></h3>
                <a href="logout.php">Esci</a>
            </div>
          </div>
        </header>
  <main>
    <div class="container">
     <div class="left">
         <a class="profile">
           <div class= "handle">
             <h4> Benvenuto, </h4>
             <p class= "text">
               @<?php
                           echo $_SESSION['username']
                       ?>
             </p>
           </div>
         </a>
         <div class= "sidebar">
           <a class="menu-item active" id="Home" href="home.php">
               <span><i class="uil uil-house-user"></i></span><h3>Home</h3>
           </a>

           <a class="menu-item" id="Esplora" href="profile.php">
               <span><i class="uil uil-create-dashboard"></i></span><h3>I tuoi Post</h3>
           </a>

         </div>
       </br>
         <a for="create-post" class="btn btn-primary logout" href="logout.php">Esci</a>

     </div>

  <div class= "middle">
        <article>

        </article>
    </div>

    <div class="right">
    <div class="post-spotify">
    <div class="GeneralInfo">
      <div class="title-spotify">
           <h1>Ascolta la tua musica</h1>
      </div>
      <div class="descrizione-spotify">
      <p>In questa sezione avrai la possiblità di cercare tutte le canzoni di milioni di artisti grazie a Spotify
      </p>
    </div>
    </div>
    <div class="search-spotify">
     <form name='element' class='element' id='search'>
     <label><input type='text' id='text' name='search' placeholder="Inserisci il titolo/artista">
     </label><label><input type='submit' id="send" value="Cerca"></label>
      <article id="view" class="hidden"></article>
     </form>
   </div>
    </div>
  </div>
  </div>

  <div id="create_post_button">
      <i class="uil uil-pen"></i>
      <p>POST</p>
  </div>
  <div class="overlay hidden" id="add_post">
      <form class="post_form" method="post" name="post_form" action="createPost.php">
          <input class="title_post" type="text" name="title" placeholder="Inserisci il Titolo">
          <input type="hidden" name="username" value=<?php echo $_SESSION["username"]?>>
          <textarea name="comment" class="comment_post" maxlength="500" placeholder="Inserisci la Descrizione del tuo post"></textarea>
          <div>
              <span class="delete_post">Annulla</span>
              <button class="publish_post">Pubblica</button>
          </div>
      </form>
  </div>
      </main>
    </body>
</html>
