
# Pasamos listado de equipos
$listado = get-content "C:\temp\equiposActivos.txt"

foreach ($pc in $listado){
    $resultado = Test-Connection $pc -count 1 -quiet  
    if ($resultado){    
        # Comprobamos que el check "compartir impresoras y archivos" en el adaptador de red está habilitado y volcamos info en un csv
        Get-NetAdapterBinding -CimSession $pc -ComponentID "ms_server" -ErrorAction SilentlyContinue | Select Name, DisplayName, ComponentID, Enabled, PSComputerName | Export-Csv C:\temp\file_print.csv -Append
    } else {
        echo "$pc desconectado" | Out-File C:\temp\file_print_sin_conexion.txt -Append
    }
}