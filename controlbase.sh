#!/bin/bash
clear
version_bdd=$(mysqld --version | cut -d" " -f4)
datos=$(service mysql status)   
estado=$(echo "$datos" | grep "Active" | cut -d":" -f2 | cut -d" " -f2)
fecha=$(echo "$datos" | grep "Active" | cut -d":" -f2,3 | cut -d" " -f6)
hora=$(echo "$datos" | grep "Active" | cut -d":" -f2,3 | cut -d" " -f7)
case $estado in
"active")
    estado_bdd="ACTIVO"
    ;;
"inactive")
    estado_bdd="INACTIVO"
    ;;
esac
clear

echo "Control del Servidor de Bases de Datos"
echo "- - - - - - - - - - - - - - - - - - - - - - - - -"
echo "Servidor: $version_bdd"
echo "Estado: $estado_bdd"
echo "- - - - - - - - - - - - - - - - - - - - - - - - -"
echo "1) Iniciar el Servidor de Bases de Datos"
echo "2) Detener el Servidor de Bases de Datos"
echo "S) Estado DETALLADO del Servidor de Bases de Datos"
echo "X) Salir"
echo "- - - - - - - - - - - - - - - - - - - - - - - - -"

read opcion

case "$opcion" in
1)
    echo "Iniciando el servidor ..."    
    sudo systemctl start mysql
    echo "Listo"
    echo "Presione ENTER para continuar"
    read ok
    bash $0
    ;;
2)
    echo "Deteniendo el servidor ..."    
    sudo systemctl stop mysql
    echo "Listo"    
    echo "Presione ENTER para continuar"
    read ok
    bash $0
    ;;
[sS])
    datos=$(service mysql status)   
    estado=$(echo "$datos" | grep "Active" | cut -d":" -f2 | cut -d" " -f2)
    fecha=$(echo "$datos" | grep "Active" | cut -d":" -f2,3 | cut -d" " -f6)
    hora=$(echo "$datos" | grep "Active" | cut -d":" -f2,3 | cut -d" " -f7)
    case $estado in
    "active")
        echo "El servidor de Base de Datos esta ACTIVO desde el $fecha a las $hora"
        ;;
    "inactive")
        echo "El servidor de Base de Datos esta DETENIDO desde el $fecha a las $hora"
        ;;
    esac
    echo "Presione ENTER para continuar"
    read ok
    bash $0
    ;;
[xX])
    clear
    ;;
*)
    bash $0
    ;;
esac

