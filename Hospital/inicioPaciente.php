<?php
    include("./conexion.php");

    session_start();
    $nss = $_SESSION["nss"];

    $consulta = $conexion->prepare("SELECT CONCAT(u.nombre,' ',u.apaterno,' ',u.apmaterno) as Nombre, p.nss, p.correo, u.telefono, u.sexo FROM Paciente p 
                                    INNER JOIN Usuario u ON p.correo=u.correo WHERE p.nss= '$nss' ");
    $consulta -> execute();
    $fila = $consulta->fetchAll(PDO::FETCH_OBJ);
?>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <title>Paciente</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Barlow:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"> 
        
        <!-- CSS Libraries -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>

        <link href="css/style.css" rel="stylesheet">
    </head>

    <bodyd style="background-color:#ACBCFF;">
        <nav class="navbar navbar-expand-lg bg-body-tertiary">
            <div class="container-fluid">
              <a class="navbar-brand" href="#">MyCare</a>
              <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
              </button>
              <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                  <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="inicioPaciente.php">Home</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="registroCita.php">Registrar una cita</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="./index.html">Salir</a>
                  </li>
                 
                </ul>
              </div>
            </div>
          </nav>

          <h1>Datos Personales</h1>
          <?php   foreach($fila as $row):?>
          <input type="text" value="<?php echo $row->Nombre;?>"><br><br>
          <input type="text" value="<?php echo $row->nss;?>"><br><br>
          <input type="text" value="<?php echo $row->correo;?>"> <br><br>
          <input type="text" value="<?php echo $row->telefono;?>"><br><br>
          <input type="text" value="<?php echo $row->sexo;?>"><br><br>
          <?php   endforeach;?>
    </body>
</html>