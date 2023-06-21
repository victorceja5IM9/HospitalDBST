<?php
    include("conexion.php");
    //session_start();
    $sesnss = $_POST["nss"];
    $fecha = $_POST["fecha"] . ' ' . $_POST["hora"];
    $especialidad =  $_REQUEST["especialidad"];


    $consulta = $conexion->prepare("EXEC regCitas '$sesnss','$fecha', '$especialidad'");
    $consulta->execute();
    if($consulta){
        header("Location: ./inicioPaciente.php");
        echo'<script type="text/javascript">
        alert("Paciente Guardado");
        window.location.href="inicioPaciente.php";
        </script>';
    }else{
        echo 'No sirvio :v';
    }
?>