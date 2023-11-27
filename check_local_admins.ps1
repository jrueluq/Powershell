# Creamos la función
function get-localadmins{
  [cmdletbinding()]
  Param(
  [string]$computerName
  )
  $group = get-wmiobject win32_group -ComputerName $computerName -Filter "LocalAccount=True AND SID='S-1-5-32-544'"
  $query = "GroupComponent = `"Win32_Group.Domain='$($group.domain)'`,Name='$($group.name)'`""
  $list = Get-WmiObject win32_groupuser -ComputerName $computerName -Filter $query
  $list | %{$_.PartComponent} | % {$_.substring($_.lastindexof("Domain=") + 7).replace("`",Name=`"","\")}
}

# Se pregunta el nombre de un equipo y se listan sus admins locales
$Workstation = Read-Host "Computer Name"
get-localadmins $Workstation


# También podemos pasarle un fichero y que se encargue de leer los hosts en cada linea. Además creamos un log para poder consultar más tarde.
$log = "C:\temp\logfile.txt"
$FILE = Get-Content "C:\temp\listado.txt"
foreach ($LINE in $FILE) {
    try {
        write-log $LINE >> $log
        get-localadmins $LINE -ErrorAction Stop 
        Write-log " ------------- " >> $log
        Write-log " " >> $log
    }
    Catch {
        Write-log "Equipo $LINE apagado o sin permisos" >> $log
        Write-log " ------------- " >> $log
        Write-log " " >> $log
    }
}