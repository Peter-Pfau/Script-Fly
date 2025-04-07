
<#
.DESCRIPTION
   OS
.EXAMPLE
   Example 1: 'vhafar3dc1.v23.med.va.gov' | .\Get-ComputerOS.ps1
.EXAMPLE
   Example 2: (Get-ADDomainController -filter * -Server v23.med.va.gov).Hostname | .\Get-ComputerOS.ps1
.EXAMPLE
   Example 3: (Get-ADForest).Domains | %{ Get-ADDomainController -Filter * -Server $_ } | .\Get-ComputerOS.ps1
.LINK
   https://github.ec.va.gov/pages/Peter-Pfau/DNS-View/Doc/
.NOTES
   Author: Peter Pfau - OIT IO SS Directory Services 
   Date:   Sun Feb 23 2025 19:04:26 GMT-0600 (Central Standard Time) 
#>

param (
   [parameter(Mandatory=$false,ValueFromPipeline=$true)]
   [string[]]$computerNames,
   # Report
   [switch]$Report,
   [string]$ReportPath = "C:\Scripts\xx-xx\Reports\Report.xxx.html",
   [string]$WebReport = "reports//Report.xxx.html",
   [string]$WebScript = "Scripts:Report.xxx.html",
   [string]$TheHeader = "computer OS",
   [string]$Org = "OIT IO SS Authentication Services",
   [string]$Service = "OS",
   # Images
   [string]$RelativeImage = "../images/xxx.png",                               # Relative Path Webpage Reports
   [string]$DistinguishedImagePath = "C:/Scripts/xx-xx/Images/",           # Distinguished Email Attachment
   [string]$TheImageFileName = "xxx.png",                                      # Image File Name Email
   [string]$emojiPlug = '<span>&#128268;</span>',                                # Emoji 🔌 style=font-size:20px 
   [string]$emojiComputer = '<span>&#128187;</span>',                            # Emoji 🖥️ style=font-size:20px 
   [string]$emojiUpward = '<span>&#128200;</span>',                              # Emoji 📈 style=font-size:20px 
   [string]$emoji = '<span>&#128202;</span>',                                    # Emoji 📊 style=font-size:20px 
   # Email
   [switch]$email,
   [string]$To = "Peter.pfau@va.gov",
   [string]$From = "Monitor@va.gov",
   [string]$Subject = "OS",
   # Colors
   [switch]$TableWrap,
   [string]$THColor = "lightgrey",
   [string]$TableColor = "#46A6FA",
   [string]$NotesColor = "#46A6FA"
)

BEGIN {
   $start = Get-Date
   $collectionTable=@()
   $totalCount = 0
}

PROCESS {
   foreach($computerName in $computerNames){
       
	$result = Invoke-command -computerName $computerName -ScriptBlock {Get-ComputerInfo -Property OsVersion}
       
	$objComputer  = New-Object psobject -Property @{
		ComputerName = $computerName
		OsVersion = $result.OsVersion
 	}
 	$collectionTable += $objComputer

       $result
       $totalCount++
   }
}

End {
$DNShostname = [System.Net.Dns]::GetHostByName(($env:computerName))
$hostname = $DNShostname.Hostname
if ($TableWrap){
     $a =      '<style>' 
     $a = $a + ' BODY{background-color:White;}'
     $a = $a + ' table {border-collapse:collapse; table-layout:auto; width:100%;border-color: White;}'
     $a = $a + ' th{background-color: lightgrey;}'
     $a = $a + ' table td {border:solid 1px white; width:100px; word-wrap:break-word;}'
     $a = $a + ' </style> ' 
 }
else{
    $a =  '<style>'
    $a = $a + ' BODY{background-color:White;}'
    $a = $a + ' TABLE{width: 96%;border-width: 1px;border-style: solid;border-color: White;border-collapse: collapse;white-space:nowrap;}'
    $a = $a + ' TH{border-width: 1px;padding: 0px;border-style: solid;border-color: White;background-color:LightGrey;white-space:nowrap}'
    $a = $a + ' TD{border-width: 0px;padding: 0px;border-style: solid;border-color: White;text-indent: 5px;background-color:White;white-space:nowrap}'
    $a = $a + '</style>'
}
    $a = $a + '<table style=width: 100%>'
    # The style must be in quotes How do I add double quotes to JSON file?'
    $a = $a + " <th style='border=2 ;border-top-color: lightgrey;text-align:left;background-color:$tableColor;font-size:small;color:White;margin-left:10px'>"+$org+'</th>'
    $a = $a + '</table>'
    $a = $a + '<table><td style=text-align:middle;font-size:small> <h3>' +$emoji+ $theHeader + '</h3></td><td style=text-align:right>' + $service + '</td></tr>'
    $a = $a + '</table>'

   $end = Get-Date
   $elapsedTime = $end - $start
   Write-Host 'Total Count: ' $totalCount
   Write-Host 'Elapsed Time: ' $elapsedTime
   $collectionTable
   #$collectionTable | select-object Name, Object, Container, WhenChanged | sort-object WhenChanged 
   #$thebody = $collectionTable | select-object Name, Object, Container, WhenChanged | sort-object WhenChanged | ConvertTo-HTML -head $a | Out-String
   $thebody = $collectionTable | ConvertTo-HTML -head $a| Out-String

   ########
   # Footer
   ########
   $end = Get-Date;$ts = New-TimeSpan $start $end
   $thebody = $thebody + '<font size=2 color=lightgrey><br>'
   $thebody = $thebody + 'Node: ' + $hostname
   $thebody = $thebody + '| User: ' + $env:Username
   $thebody = $thebody + '| RunTime:  '+ (get-date).ToString()
   $thebody = $thebody + '| Duration: '+$ts.hours+':'+ $ts.Minutes+':'+$ts.Seconds 
   $thebody = $thebody + '| <a href=//'+$hostname + $WebScript.Split(':')[0] +'>' + $WebScript.Split(':')[1]  +'</a>'
   $thebody = $thebody + '</font><br><br>'

   #######################
   # // Send Email as HTML
   #######################
   If($email.Ispresent){
       send-mailmessage -to $To -from $From -subject $Subject -body $thebody -smtpServer smtp.va.gov -bodyAshtml
       write-host Email sent to $To
   }
}

