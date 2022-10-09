Domain: riskonnect.rk1
Datacenter: FRA
Script Name: riskconnect-FRA.ps1






EXAMPLES

 Method 1: 
powershell -executionpolicy bypass D:\Riskconnect\riskonnect\FRA\riskconnect-FRA.ps1 -CoreTicket <CoreTicketNumber>
         
        (If VM's are cloned, run first "Set drive letter D in Clone VM.txt" on local server's PowerShell individually).


Method 2: (Preferred)
D:\Riskconnect\riskonnect\FRA> .\riskconnect-FRA.ps1 -CoreTicket <CoreTicketNumber>
        
        
         (If VM's are cloned, run first "Set drive letter D in Clone VM.txt" on local server's Powershell individually).
