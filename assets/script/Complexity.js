        // // get the complexity radio buttons
        // var complexity = document.getElementsByName("complexity");
        // // loop through the radio buttons
        // for (var i = 0; i < complexity.length; i++) {
        //     // add an event listener to each radio button
        //     complexity[i].addEventListener("change", function() {
        //         // alert the value of the selected radio button
        //         alert(this.value);
        //     });
        // }
        var MultiThreaded = document.getElementById("Multi-Threaded");
        MultiThreaded.addEventListener("change", function() {
            // alert the value of the selected radio button
            //alert(this.value);
            var scriptName = document.getElementById("script-name").value;
            document.getElementById("example1").innerHTML = "Example 1:  .\\" + scriptName + " -ComputerNames 'vhafar3dc1.v23.med.va.gov','vhafar3dc2.v23.med.va.gov'";
            document.getElementById("example2").innerHTML = "Example 2:  .\\" + scriptName + " -inputFile 'C:\\temp\\computers.txt'";
            document.getElementById("example3").innerHTML = "Example 3:  .\\" + scriptName + " -DomainName 'v23.med.va.gov'";
            var scriptDescription = document.getElementById("script-description").value;
            document.getElementById("script-description").value = scriptDescription + " script is multi-threaded.";
        });