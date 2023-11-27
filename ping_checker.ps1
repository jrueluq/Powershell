# Pasamos una lista de equipos y ejecutará un ping, mostrando en verde los equipos conectados y en rojo los que no tenemos conexion.
$listado=("Computername1", "Computername2", "Computername3")
	
foreach ($pc in $listado){
	
    if (Test-Connection $pc -count 1 -quiet){
        Write-host $pc -ForegroundColor Green
    } else {
        Write-host $pc -ForegroundColor Red
    }
}