# Pasamos los equipos a comprobar en un .txt. Por cada equipo que da Ping, 
# se muestra el S.O.. IP y se comprueba si la ruta en la que debería instalarse LAPS existe

$listado = get-content "C:\temp\equipos.txt"

foreach ($pc in $listado){

    $resultado = Test-Connection $pc -count 1 -quiet
        
    if ($resultado){
    
        Write-Host "$pc conectado"
        Get-ADComputer $pc -Properties Name,Operatingsystem,OperatingSystemVersion,IPv4Address |
            Sort-Object -Property Operatingsystem |
                Select-Object -Property Name,Operatingsystem,OperatingSystemVersion,IPv4Address
                
        $instalado = Test-Path \\$pc\c$\"Program Files"\LAPS\CSE\AdmPwd.dll

        if ($instalado){
            Write-Host "Archivo AdmPwd.dll encontrado" -ForegroundColor Green
            Write-Host " "
        } else {
            Write-Host "No se encuentra el archivo AdmPwd.dll" -ForegroundColor Yellow
            Write-Host " "
        }
              
    } else {
        Write-Host "$pc sin conectividad" -ForegroundColor Red
        Get-ADComputer $pc -Properties Name,Operatingsystem,OperatingSystemVersion,IPv4Address |Sort-Object -Property Operatingsystem |Select-Object -Property Name,Operatingsystem,OperatingSystemVersion,IPv4Address
        Write-Host " "
    }
}