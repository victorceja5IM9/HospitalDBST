<?php

    $conexion = new PDO("sqlsrv:server=LAPTOP-82VKEFPB\SQLEXPRESS;database=HospitalDBST");
    //$consulta = $conexion->prepare("Select * from Usuario");
    //$consulta->execute();
    //$datos = $consulta->fetchAll(PDO::FETCH_ASSOC);
    if($conexion){
        echo "hola";
    }else{
        echo "adios";
    }
    //var_dump($datos);
?>