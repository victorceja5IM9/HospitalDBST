<?php
    include("conexion.php");
    session_start();
    $consulta = $conexion->prepare("Select nEspecialidad from cat_especialidad");
    $consulta -> execute();
    $fila = $consulta->fetchAll(PDO::FETCH_OBJ);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="citaEstilo.css">
    <title>Registro de Citas Médicas</title>

     <!-- Favicon -->
     <link href="img/favicon.ico" rel="icon">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Barlow:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"> 

<!-- CSS Libraries -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>

<link href="css/style.css" rel="stylesheet">
</head>
<body style="background-color: #DBDFAA;">
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
                    <a class="nav-link" href="#">Registrar una cita</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="./index.html" onClick="<?php session_destroy();?>">Salir</a>
                  </li>
                 
                </ul>
              </div>
            </div>
          </nav>
    <form method="post" action="registrarCita.php">
        <H1>Registro de Citas Médicas</H1>
        <label for="nombre">Numero de Seguridad Social:</label>
        <input type="text" id="nss" name="nss"  value='<?php echo $_SESSION["nss"];?>'><br><br>

        <label for="fecha">Fecha:</label>
        <input type="date" id="fecha" name="fecha" required min="<?php echo date("Y-m-d");?>" max="2040-12-31"><br><br>

        <label for="hora">Hora:</label>
        <input type="time" id="hora" name="hora" required min="08:00" max="21:00"><br><br>

        <label for="especialidad">Especialidad:</label>
        <select id="especialidad" name="especialidad" required>
        <option value="">Seleccionar especialidad</option>
        <?php
            foreach($fila as $row):
        ?>
        <option value="<?php echo $row->nEspecialidad;?>"><?php echo $row->nEspecialidad;?></option>
        <?php
            endforeach;
        ?>     
        </select><br><br>

        <input type="submit" value="Registrar cita">
  </form>
</body>
</html>