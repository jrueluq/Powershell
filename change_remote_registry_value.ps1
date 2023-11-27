# Consulta, cambio y consulta del nuevo valor de una clave de registro

$listado=("Computername1", "Computername2")

foreach ($pc in $listado){
    Invoke-Command -ComputerName $pc -scriptblock {Get-ItemProperty -path HKLM:\SYSTEM\CurrentControlSet\Control\Filesystem\ -name NtfsDisable8dot3NameCreation}
    Invoke-Command -ComputerName $pc -scriptblock {set-ItemProperty -path HKLM:\SYSTEM\CurrentControlSet\Control\Filesystem\ -name NtfsDisable8dot3NameCreation -value 1}
    Invoke-Command -ComputerName $pc -scriptblock {Get-ItemProperty -path HKLM:\SYSTEM\CurrentControlSet\Control\Filesystem\ -name NtfsDisable8dot3NameCreation}
}
