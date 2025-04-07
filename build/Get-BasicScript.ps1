<#
.Synopsis
Get the status of the DNS service.
.Description
Get the status of the DNS service.
.Example
(Get-ADDomainController -filter * -Server v23.med.va.gov).Hostname | .\Get-DNSstatus.ps1
#>
param (
[parameter(Mandatory=$false,ValueFromPipeline=$true)]
[string]$ComputerName = $env:COMPUTERNAME
)

Begin {
$global:start = Get-Date
$global:collectionTable=@()
$global:totalCount = 0
}
Process {
Invoke-Command -ComputerName $ComputerName -scriptblock {Get-Service 'DNS' | Sort-Object status}

$global:totalCount++
$global:collectionTable += $PSItem
}

End {
$global:end = Get-Date
$global:elapsedTime = $global:end - $global:start
Write-Host 'Total Count: ' $global:totalCount
Write-Host 'Elapsed Time: ' $global:elapsedTime
}