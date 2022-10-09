<#
Name              : riskconnect-ORD
Version           : 1.1.1.0, 21/03/2022
Author            : Ujjawal Mandal
CompanyName       : Rackspace Inc

    .SYNOPSIS
    Custom QC script for Riskconnect (897998).

    .DESCRIPTION
    Custom QC script for Riskconnect (897998) that uses WHAM templates to configures servers per their AMG guidelines.

   QC Steps for WINDOWS VMs
For Clones:
-Ensure vDisk 2 (D_DRIVE) is associated with the drive letter D
-CD_ROM can be associated with driver letter Z

1.Verify domain is set to starbase or stars-net
2.FRA patching, move computer object to Rackspace Computers(Security Group)  05/26/2020
  2a.  Patching for US servers deployed should be placed on the following settings:
       -WuServer will remain pointed to racksapce.  ie.  DFW servers show http://microsoftupdate.dfw1.rackspace.com 
registry setting.
      -AuOptions  2  Notify before download
      -NoAutoUpdate 1  Disable automatic Updates
3.Set custom NTP configuration. Replace Rackspace DC NTP Servers with customer domain controllers.


.PARAMETER Ticket
This parameter will take a CORE Ticket number.

.EXAMPLES
 Method 1: 
 powershell -executionpolicy bypass D:\Riskconnect\stars\DFW\Stars-DFW.ps1 -Ticket <TicketNumber>
        EXAMPLE:  powershell -executionpolicy bypass D:\Riskconnect\stars\DFW\Stars-DFW.ps1 -Ticket 220201-06421
        
        (If VM's are cloned, run first "Set drive letter D in Clone VM.txt" on local server's PowerShell individually).

Method 2:(Preferred)
PS D:\Riskconnect\stars\DFW> .\Stars-DFW.PS1 -Ticket <TicketNumber>
        EXAMPLE:  PS D:\Riskconnect\stars\DFW> .\Stars-DFW.PS1 -Ticket 220201-06421
        
         (If VM's are cloned, run first "Set drive letter D in Clone VM.txt" on local server's Powershell individually).
         
         
         Please check "Riskconnect_README.docx" inside Riskconnect.zip for detailed information about how to use these scripts per domain and datacenter.


.LINK
Example output:
    https://core.rackspace.com/py/Ticket/view.pt?ref_no=220318-01576
#>

Param (
[Parameter()]$Ticket=(Read-Host "Enter Ticket Number")
)
Get-volumedisk -Ticket $Ticket 
$text=ConvertTo-BBCode -Data $($WhamOutput | Select-Object *) | Out-String ;$text 
Add-CoreTicketUpdate -Text $text -TicketNumber $Ticket
get-domain -Ticket $Ticket 
$text=ConvertTo-BBCode -Data $($WhamOutput | Select-Object *) | Out-String ;$text 
Add-CoreTicketUpdate -Text $text -TicketNumber $Ticket
set-windowsupdatesetting -Ticket $Ticket -AUOptions 2  -NoAutoUpdate 1 
$text=ConvertTo-BBCode -Data $($WhamOutput | Select-Object *) | Out-String ;$text 
Add-CoreTicketUpdate -Text $text -TicketNumber $Ticket

get-windowsupdatesetting -Ticket $Ticket 
$text=ConvertTo-BBCode -Data $($WhamOutput | Select-Object *) | Out-String ;$text 
Add-CoreTicketUpdate -Text $text -TicketNumber $Ticket

Set-RegValue -Ticket $Ticket -Key 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Parameters\' -Name 'Type' -Value 'NTP' -Type 'String' 
$text=ConvertTo-BBCode -Data $($WhamOutput | Select-Object *) | Out-String ;$text 
Add-CoreTicketUpdate -Text $text -TicketNumber $Ticket

Get-RegValue -Ticket $Ticket -Key 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Parameters\' -Name Type 
$text=ConvertTo-BBCode -Data $($WhamOutput | Select-Object *) | Out-String ;$text 
Add-CoreTicketUpdate -Text $text -TicketNumber $Ticket

Set-RegValue -Ticket $Ticket -Key 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Parameters\' -Name 'NTPserver' -Type 'String' -Value '1127437-CHDC01.riskonnect.rk1,0x01 1127438-CHDC02.riskonnect.rk1,0x01' 
$text=ConvertTo-BBCode -Data $($WhamOutput | Select-Object *) | Out-String ;$text 
Add-CoreTicketUpdate -Text $text -TicketNumber $Ticket

Get-RegValue -Ticket $Ticket -Key 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Parameters\' -Name 'NTPserver' 
$text=ConvertTo-BBCode -Data $($WhamOutput | Select-Object *) | Out-String ;$text 
Add-CoreTicketUpdate -Text $text -TicketNumber $Ticket

Get-scomconfiguration -Ticket $Ticket 
$text=ConvertTo-BBCode -Data $($WhamOutput | Select-Object *) | Out-String ;$text 
Add-CoreTicketUpdate -Text $text -TicketNumber $Ticket
