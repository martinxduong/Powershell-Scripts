# Import the Active Directory module
Import-Module ActiveDirectory


# Function to disable a computer and set the description
function disableComputer {
    param (
        [Parameter(Mandatory=$true)]
        [string]$computerName
    )

    # Disable the computer
    $computer = Get-ADComputer -Filter { Name -eq $computerName } -ErrorAction SilentlyContinue
    if ($computer) {
        $computer | Disable-ADAccount

        # Set the description
        $description = "Disabled " + (Get-Date -Format "MM-dd-yy")
        Set-ADComputer -Identity $computerName -Description $description

        Write-Host "Disabled computer: $computerName"
    } else {
        Write-Host "Computer does not exist: $computerName"
    }
}


# Function to enable a computer and clear the description
function enableComputer {
    param (
        [Parameter(Mandatory=$true)]
        [string]$computerName
    )

    # Enable the computer
    $computer = Get-ADComputer -Filter { Name -eq $computerName } -ErrorAction SilentlyContinue
    if($computer) {
        $computer | Enable-ADAccount

        # Clear the description
        Set-ADComputer -Identity $computerName -Description $null

        Write-Host "Enabled computer: $computerName"
    } else {
        Write-Host "Computer does not exist: $computerName"
    }
}


# Prompt the user to select a CSV file
$openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$openFileDialog.Filter = "CSV Files (*.csv)|*.csv"
$openFileDialog.Title = "Select a CSV File"
$dialogResult = $openFileDialog.ShowDialog()

# Check if a file was selected
if ($dialogResult -eq "OK") {
    $csvFile = $openFileDialog.FileName

    # Read the CSV file and disable/enable computers (First row is treated as a header row and does not iterate over)
    $computers = Import-Csv $csvFile
    foreach ($computer in $computers) {
        $computerName = $computer.ComputerName
        #enableComputer -computerName $computerName
        disableComputer -computerName $computerName
    }
}

