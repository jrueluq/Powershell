foreach ($pc in $listado){

    $resultado = Test-Connection $pc -count 1 -quiet
    
    if ($resultado){
    
        $ComputerInfoObj = [PSCustomObject]@{
    
            Equipo = $pc
    
               # Comprobamos puertos
            Port135 = Test-NetConnection $pc -Port 135 -ErrorAction SilentlyContinue | Select-Object -ExpandProperty TcpTestSucceeded
            Port139 = Test-NetConnection $pc -Port 139 -ErrorAction SilentlyContinue | Select-Object -ExpandProperty TcpTestSucceeded
            Port445 = Test-NetConnection $pc -Port 445 -ErrorAction SilentlyContinue | Select-Object -ExpandProperty TcpTestSucceeded


            # Comprobamos servicios
            ServerService = Get-Service -ComputerName $pc -Name LanmanServer | Select-Object -ExpandProperty Status
            RemoteRPC = Get-Service -ComputerName $pc -Name RpcSS | Select-Object -ExpandProperty Status
            RemoteRegistry = Get-Service -ComputerName $pc -Name RemoteRegistry | Select-Object -ExpandProperty Status
            Wmi = Get-Service -ComputerName $pc -Name Winmgmt | Select-Object -ExpandProperty Status
            Firewall = Get-Service -ComputerName $pc -Name MpsSvc | Select-Object -ExpandProperty Status
        
        }

        $ComputerInfoObj

    } else {

        $ComputerInfoObj = [PSCustomObject]@{
    
            Equipo = $pc
    
               # Comprobamos puertos
            Puerto135 = "Sin conexion"
            Puerto139 = "Sin conexion"
            Puerto445 = "Sin conexion"


            # Comprobamos servicios
            ServerService = "Sin conexion"
            RemoteRPC = "Sin conexion"
            RemoteRegistry = "Sin conexion"
            Wmi = "Sin conexion"
            Firewall = "Sin conexion"
    }
       
        $ComputerInfoObj
       

    }

}
