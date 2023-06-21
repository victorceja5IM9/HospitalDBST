<?php
    include("conexion.php");
    session_start();
    $cedula = $_SESSION["cedula"];
    $consulta = $conexion->prepare(" SELECT CONCAT(u.nombre,' ',u.apaterno,' ',u.apmaterno) as Nombre, c.idCita, c.nss, c.idConsultorio,CONVERT(CHAR(10), c.fechaCita,108) as Hora 
    FROM Paciente p, Cita c, Usuario u WHERE p.correo=u.correo AND c.nss=p.nss AND c.cedula= '$cedula' and DAY(c.fechaCita) = DAY(GETDATE())");
    $consulta -> execute();
    $fila = $consulta->fetchAll(PDO::FETCH_OBJ);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="consultaCitaEstilo.css">
    <title>Consulta de Citas Médicas</title>
     <!-- Favicon -->
     <link href="img/favicon.ico" rel="icon">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Barlow:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"> 

<!-- CSS Libraries -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>

<link href="css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
            <div class="container-fluid">
              <a class="navbar-brand" href="#">MyCare</a>
              <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
              </button>
              <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                  <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="inicioDoctor.html">Home</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="consultaCitasDoctor.php">Citas de hoy</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="./index.html" onClick="<?php session_destroy();?>">Salir</a>
                  </li>
                 
                </ul>
              </div>
            </div>
          </nav>
        <h1>Consulta de Citas Médicas</h1>

        <table class="consultorio1">
          <tr>
            <th>Cita</th>
            <th>NSS</th>
            <th>Nombre</th>
            <th>Hora</th>
            <th>Consultorio</th>
          </tr>
          <?php
                foreach($fila as $row):

                    
            ?>
            <tr>
                <td><?php echo $row2->idCita;?></td>
                <td><?php echo $row2->nss;?></td>
                <td><?php echo $row2->Nombre;?></td>
                <td><?php echo $row2->Hora;?></td> 
                <td><?php echo $row2->idConsultorio;?></td> 
            </tr>
            <?php 
            endforeach;
        ?>
          <!-- Agrega más filas según las citas registradas para el Consultorio 1 -->
        </table>
      
        
</body>
</html>