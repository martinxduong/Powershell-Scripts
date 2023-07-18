bitlockerInfoGithub.csv
The CSV file is a template of the output after running the script.

getBitlockerGithub.ps1
The Windows Powershell Script uses domain as well as organizational unit. When using, be sure to change DC and OU to be what is applicable.
The script outputs the CSV file in the current users' Desktop folder.


Please Note: For this script to run properly, administrative privileges, RSAT Tools, and the Active Directory PowerShell Module may be required. 
Additionally, ensure that the PowerShell execution policy allows script execution.
