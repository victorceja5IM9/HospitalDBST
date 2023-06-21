<?php

    include ("conexion.php");
    $correo = $_POST["correo"];
    $contra = $_POST["contrasena"];
    $nombrepila = $_POST["nombre"];
    $app = $_POST["apellido_paterno"];
    $apm = $_POST["apellido_materno"];
    $tel = $_POST["telefono"];
    $curp = $_POST["curp"];
    $nss = $_POST["nss"];
    $fnac = $_POST["fnac"];
    $sexo = $_POST["sexo"];
    $tpusr = 2;
    $peso = 0.00;
    $altura = 0.00;

    $consulta = $conexion->prepare("EXEC INSPaciente '$correo','$nombrepila','$app','$apm','$contra','$curp','$tel','$fnac','$sexo','$tpusr','$nss','$peso','$altura'");

    $consulta->execute();
    if($consulta){
        header("Location: ./login.html");
        echo'<script type="text/javascript">
        alert("Paciente Guardado");
        window.location.href="registroPaciente.html";
        </script>';
    }
?>