<#
Name              : starbase-FRA
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


.PARAMETER CoreTicket
This parameter will take a CORE CoreTicket number.

.EXAMPLES
 Method 1: 
 powershell -executionpolicy bypass D:\Riskconnect\stars\DFW\Stars-DFW.ps1 -CoreTicket <CoreTicketNumber>
        EXAMPLE:  powershell -executionpolicy bypass D:\Riskconnect\stars\DFW\Stars-DFW.ps1 -CoreTicket 220201-06421
        
        (If VM's are cloned, run first "Set drive letter D in Clone VM.txt" on local server's PowerShell individually).

Method 2:(Preferred)
PS D:\Riskconnect\stars\DFW> .\Stars-DFW.PS1 -CoreTicket <CoreTicketNumber>
        EXAMPLE:  PS D:\Riskconnect\stars\DFW> .\Stars-DFW.PS1 -CoreTicket 220201-06421
        
         (If VM's are cloned, run first "Set drive letter D in Clone VM.txt" on local server's Powershell individually).
         
         
         Please check "Riskconnect_README.docx" inside Riskconnect.zip for detailed information about how to use these scripts per domain and datacenter.


.LINK
Example output:
    https://core.rackspace.com/py/CoreTicket/view.pt?ref_no=220318-01576
#>


Param (
[Parameter()]$CoreTicket=(Read-Host "Enter CoreTicket Number")
)
Get-volumedisk -CoreTicket $CoreTicket -OutputTicket $CoreTicket
get-domain -CoreTicket $CoreTicket -OutputTicket $CoreTicket
set-windowsupdatesetting -CoreTicket $CoreTicket -AUOptions 2  -NoAutoUpdate 1 -OutputTicket $CoreTicket
get-windowsupdatesetting -CoreTicket $CoreTicket -OutputTicket $CoreTicket
Set-RegValue -CoreTicket $CoreTicket -Key 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Parameters\' -Name 'Type' -Value 'NTP' -Type 'String' -OutputTicket $CoreTicket
Get-RegValue -CoreTicket $CoreTicket -Key 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Parameters\' -Name Type  -OutputTicket $CoreTicket
Set-RegValue -CoreTicket $CoreTicket -Key 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Parameters\' -Name 'NTPserver' -Type 'String' -Value '1069743-FRVW041.starbase-emea.local,0x01 1069744-FRVW042.starbase-emea.local,0x01' -OutputTicket $CoreTicket
Get-RegValue -CoreTicket $CoreTicket -Key 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Parameters\' -Name 'NTPserver' -OutputTicket $CoreTicket
Get-scomconfiguration -CoreTicket $CoreTicket -OutputTicket $CoreTicket
