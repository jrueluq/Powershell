# habilitar RSS en adaptadores

$computerList=("Computername1", "Computername2")

foreach ($pc in $computerList){

Invoke-Command -ComputerName $pc -ScriptBlock {get-netadapterrss | select systemname, enabled, interfacealias} 
Invoke-Command -ComputerName $pc -ScriptBlock {enable-netadapterrss} 
Invoke-Command -ComputerName $pc -ScriptBlock {get-netadapterrss | select systemname, enabled, interfacealias} 

}



