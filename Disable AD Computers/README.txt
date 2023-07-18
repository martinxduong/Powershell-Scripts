computersDisableGithub.csv
The CSV file is a template for the file that I used to parse through the computers in the CSV.

disableADGithub.ps1
The Windows PowerShell Script has two functions: disableComputer & enableComputer. The script parses through the CSV file (skipping the first row since it is a header file)
and either disables or enables the computer in Active Directory. If the computer is not found in Active Directory, the script will silently continue and display a message
stating that the computer does not exist.


Please Note: For this script to run properly, administrative privileges, RSAT Tools, and the Active Directory PowerShell Module may be required. 
Additionally, ensure that the PowerShell execution policy allows script execution.
