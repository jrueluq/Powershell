# LAPS de todos los windows activos del dominio

$ou = "OU=Computers,DC=domain,DC=lan"

$listado = get-adcomputer -SearchBase $ou -filter 'Operatingsystem -like "*Windows*" -and enabled -eq $True' -Property name | Select-Object -ExpandProperty name

foreach ($pc in $listado){
    
    $ComputerInfoObj = [PSCustomObject]@{
        Name = get-adcomputer $pc -Properties * | Select-Object -ExpandProperty name  
        Password = get-adcomputer $pc -Properties * | Select-Object -ExpandProperty ms-mcs-admpwd -ErrorAction SilentlyContinue
        Expiracion = get-adcomputer $pc -Properties * | Select-Object @{Name="ms-mcs-admpwdexpirationtime";Expression={$([datetime]::FromFileTime([convert]::ToInt64($_."ms-MCS-AdmPwdExpirationTime",10)))}}
        Lastlog=Get-ADComputer $pc -Properties * | Select-Object -ExpandProperty LastLogonDate
        OperatingSystem = Get-ADComputer $pc -Properties * |Select-Object -ExpandProperty OperatingSystem
        UnidadOrg = Get-ADComputer $pc -Properties * | Select-Object -ExpandProperty DistinguishedName
        Descripcion = get-adcomputer $pc -Property Description | Select-Object -ExpandProperty Description -ErrorAction SilentlyContinue
    }    

    $ComputerInfoObj | Export-Csv "C:\temp\laps.csv" -append
}

# ============================================================================================================================== #

# En este caso, le pasamos en un .txt los equipos a comprobar

$listado = get-content C:\temp\listado.txt

foreach ($pc in $listado){
    
    $ComputerInfoObj = [PSCustomObject]@{
        Name = get-adcomputer $pc -Properties * | Select-Object -ExpandProperty name  
        Password = get-adcomputer $pc -Properties * | Select-Object -ExpandProperty ms-mcs-admpwd -ErrorAction SilentlyContinue
        Expiracion = get-adcomputer $pc -Properties * | Select-Object @{Name="ms-mcs-admpwdexpirationtime";Expression={$([datetime]::FromFileTime([convert]::ToInt64($_."ms-MCS-AdmPwdExpirationTime",10)))}}
        Lastlog=Get-ADComputer $pc -Properties * | Select-Object -ExpandProperty LastLogonDate
        OperatingSystem = Get-ADComputer $pc -Properties * |Select-Object -ExpandProperty OperatingSystem
        UnidadOrg = Get-ADComputer $pc -Properties * | Select-Object -ExpandProperty DistinguishedName
        Descripcion = get-adcomputer $pc -Property Description | Select-Object -ExpandProperty Description -ErrorAction SilentlyContinue
    }    
    
    $ComputerInfoObj | Export-Csv "C:\temp\laps.csv" -append
}    
