$currentUser = $env:USERNAME
$ouDN = "DC=work,DC=lcl"
#ouDN = "OU=Organizational Unit,DC=work,DC=lcl"
$computers = Get-ADComputer -Filter * -SearchBase $ouDN |
    Sort-Object Name |
    Select-Object -ExpandProperty Name


$keyInfoList = foreach ($computer in $computers) {
    $objComputer = Get-ADComputer $computer
    $objBitlocker = Get-ADObject -Filter {objectclass -eq 'msFVE-RecoveryInformation'} -SearchBase $objComputer.DistinguishedName -Properties 'msFVE-RecoveryPassword'
    
    if ($objBitlocker) {
        [PSCustomObject]@{
            ComputerName = $computer
            RecoveryKey = $objBitlocker.'msFVE-RecoveryPassword'
        }
    } else {
        [PSCustomObject]@{
            ComputerName = $computer
            RecoveryKey = "NONE"
        }
    }
}

$outputPath = "C:\Users\$currentUser\Desktop\bitlockerInfo.csv"
$keyInfoList | Export-Csv -Path $outputPath -NoTypeInformation