# En Powershell, los admins del dominio tienen el atributo admincount=1. Definimos un listado de con estos admins:
$uniqueFile1 = ("Adm1",
                "Adm2",
                "Adm3")

# Con la siguiente consulta aparecerá cualquier usuario que no esté en el listado anterior y tenga el atributo admincount=1 
get-aduser -filter 'enabled -eq $True -and adminCount -ge 1' -Properties * | Select -ExpandProperty Name | Where-Object { $uniqueFile1 -notcontains $_ } #| Out-File .\OutputFile.txt

# ====================================================================================================================================================================================================#

# Sobre el apartado anterior, añadimos que se envíe un correo si se detecta en la tarea programada algún usuario más con admincount=1 
$textEncoding = [System.Text.Encoding]::UTF8

$uniqueFile1 = ("Adm1",
                "Adm2",
                "Adm3")

$resultado = get-aduser -filter 'enabled -eq $True -and adminCount -eq 1' -Properties * | Select -ExpandProperty Name | Where-Object { $uniqueFile1 -notcontains $_ }

if ($resultado.length -ne 0){
          
    $subject="Usuario con atributo AdminCount detectado"

    # Cuerpo del mensaje usando HTML.
    $body ="
        <p> El usuario '$resultado' se ha agregado como Admin <br>
        </P>"

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    $User = # User
    $PWord = ConvertTo-SecureString -String 'Password' -AsPlainText -Force
    $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
    $EmailParams = @{
         SmtpServer = #'smtp.office365.com'
         Port = 587
         UseSsl = $true
         Credential  = $Credential 
         From = 
         To = 
         Subject = $subject
         Body = $body
         BodyasHTML = $true
         Encoding=$textEncoding        
       }

      Send-MailMessage @EmailParams

}



    
