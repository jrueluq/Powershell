# Se recorre cada OU en busca de servidores con el rol IIS instalado.

$listado = ""

$servers= @("OU=Domain Controllers,DC=domain,DC=lan",
            "OU=Servers_Windows,OU=Site1,DC=domain,DC=lan",
            "OU=Servers_Windows,OU=Site2,DC=domain,DC=lan")

foreach ($elemento in $servers){     
    $listado = Get-ADComputer -SearchBase $elemento -filter 'Operatingsystem -like "*Windows*" -and enabled -eq $True' | select -ExpandProperty Name
    foreach ($pc in $listado){
        Get-WindowsFeature Web-Server -ComputerName $pc | select @{Name="Hostname";Expression={$pc}}, InstallState | export-csv C:\Users\admtmp\Documents\Listados\IIS\listadoIIS.csv -append
    }
}

