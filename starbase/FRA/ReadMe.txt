Domain: starbase-emea.local
Datacenter: AMS
Scrpt Name: starbase-FRA.ps1



.EXAMPLES

 Method 1: 
 powershell -executionpolicy bypass D:\Riskconnect\starbase\FRA\starbase-FRA.ps1 -CoreTicket <CoreTicketNumber>
         
        (If VM's are cloned, run first "Set drive letter D in Clone VM.txt" on local server's PowerShell individually).


Method 2: (Preferred)
D:\Riskconnect\starbase\FRA> .\starbase-FRA.ps1 -CoreTicket <CoreTicketNumber>
        
        
         (If VM's are cloned, run first "Set drive letter D in Clone VM.txt" on local server's Powershell individually).
