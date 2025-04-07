function submitScript() {
    var scriptName = document.getElementById("script-name").value;
    var scriptFunction = document.getElementById("script-function").value;
    var scriptType = document.getElementById("script-type").value;
    var scriptDescription = document.getElementById("script-description").value;
    var scriptContent = document.getElementById("script-content").value; 
    var scriptContent = scriptContent.replace(/\n/g, "<br>");       
    var scriptExample1 = '"vhafar3dc1.v23.med.va.gov" | .\\'
    var scriptExample2 = '(Get-ADDomainController -filter * -Server v23.med.va.gov).Hostname | .\\'
    var scriptExample3 = '(Get-ADForest).Domains | %{ Get-ADDomainController -Filter * -Server $_ } | .\\'
    var Begin = "Begin {<br>$start = Get-Date<br>$collectionTable=@()<br>$totalCount = 0<br>}";
    var Process = "Process {<br>"+ scriptContent +"<br><br>$result<br><br>$totalCount++<br>$collectionTable += $result<br>}<br>";
    var End = "End {<br>$end = Get-Date<br>$elapsedTime = $end - $start<br>Write-Host 'Total Count: ' $totalCount<br>Write-Host 'Elapsed Time: ' $elapsedTime<br>}";

    output = "<# <br>.Synopsis<br>    " + scriptDescription + "<br>.Description<br>    " + scriptDescription + 
    "<br>.Example<br>    " + scriptExample1+ scriptName + "<br>.Example<br>" + scriptExample2 + scriptName + "<br>.Example<br>" + scriptExample3 + scriptName+"<br>#>" +
    "<br><br> param ( <br> [parameter(Mandatory=$false,ValueFromPipeline=$true)] <br> [string]$ComputerName = $env:COMPUTERNAME <br> ) <br> <br> " +
    Begin + "<br> " + 
    Process + "<br> " + 
    End + "<br> "
    //output = "hello world"
    document.getElementById("Popupwindow").innerHTML = output
    modal.style.display = "block";

} 