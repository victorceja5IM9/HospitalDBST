<?php
    include("conexion.php");

    $usrnm = $_POST["username"];
    $pass = $_POST["password"];

    $consulta = $conexion->prepare("Select * from Usuario where correo='$usrnm' and contrasenia= '$pass'");
    
    $consulta->execute();
    $fila = $consulta->fetch(PDO::FETCH_OBJ);
    if($fila){
        if($fila->tusuario == 2){
            $consulta = $conexion->prepare("Select nss from Paciente where correo='$usrnm'");
            $consulta->execute();
            $fila2 = $consulta->fetch(PDO::FETCH_OBJ);
            session_start();
            $_SESSION["nss"] = $fila2->nss;  
            header("Location: ./inicioPaciente.php"); 
            
        }else if($fila->tusuario == 1){
            $consulta = $conexion->prepare("Select cedula from Doctor where correo='$usrnm'");
            $consulta->execute();
            $fila2 = $consulta->fetch(PDO::FETCH_OBJ);
            session_start();
            $_SESSION["cedula"] = $fila2->cedula;
            header("Location: ./inicioDoctor.php");   
        }else if($fila->tusuario == 3){
            header("Location: ./secretariaConsultaCita.php");
        }
        
    }else{
        echo 'Usuario no encontrado';
    }
?>
