Try {

Write-Host "
The following script will scan a specified list of computers for a specific key that you are searching for.
The purpose of this script is to replace the reg query scripts and to be adaptable with no need to change code. 

INSTRUCTIONS:
    
    - Copy and Paste a list of computers inside a text file and save it anywhere on your computer
    - First prompt will ask you for the text file and its path
        - ex.   c:\temp\testComputer.txt
    - Second prompt will ask you for the key you are searching for 
        - ex.    SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\etc...
    - No time for coffee because this script runs fast :) 

NOTE: key names should be as specific as possible in the following format software\microsoft\windows\etc\etc\etc
by making them specific it will lead to faster returns due to the script using the -recurse tag. 

NOTE: This script uses multi-threading so it does the following 
 - First this script will execute code on 10 computers at one time (anymore threads might be to big of a burden on your computer)
 - During the 10 threads it will execute the following 
    - Ping the computer to ensure it is up
    - If the ping is good it will then check the registry of the remote computer for that key you specified.
    - If the ping is timed out it won't check registry and move on 

NOTE: This script looks in the HKEY Hive of the remote registry SO DO NOT PUT IT AS PART OF THE KEY NAME!

NOTE: If you don't see the key that means its not there and will require further investigation

THE FOLLOWING WILL LIST SOME TROUBLESHOOTING STEPS THAT YOU COULD TAKE IF THIS SCRIPT FAILS FOR ANY REASON
 - Ensure you have the PSRemoteRegistry Module imported into PowerShell
    - The PSRemoteRegistry Module can be found on the CRISP_Contractors portal
        -\\r02.med.va.gov\cssl\Client Tech\Crisp_Contractors\Scripts and Fixes
    - unzip the PSRemoteRegistry zip folder and copy the unzipped folder into the module directory
        - C:\Windows\System32\WindowsPowerShell\v1.0\Modules
    - Ensure that the module is imported by running Import-Module -Name PSRemoteRegistry -Force

 - Set your execution policy to allow scripts to be executed
    - Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
        - or set it to unrestricted if you needed to
 
   " -ForegroundColor Yellow -BackgroundColor Black

$computerStart = Read-Host "Enter the path to the list of computers you are wanting to scan i.e. c:\temp\testComputer.txt"
$searchRegistryStringQuestion = Read-Host "Enter the key you would like to search for (i.e. SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\KEY) DO NOT PUT HKEY"
$searchRegistryString = $searchRegistryStringQuestion.Trim()


$computer = Get-Content $computerStart

$maxRunCount = 10


$ScriptBlock = {
    
    #establishing a list of parameters that is being passed into the scriptblock 
    param($computers, $regKeyToSearch)

    #function that pings the computer
    function pingFunc ($comp) {

    #Beginning of a try/catch statement that deals with errors
     Try {
        #Setting the results of a Test-Connection -quiet command into a variable and declaring other variables
        $testingConnection = Test-Connection -ComputerName $comp -Count 1 -Quiet
        $trueReturnPing = 'True'
        $falseReturnPing = 'False'

        #if statement that test the conditions of the $testingConnection Command
        if ($testingConnection -eq 'True') {
            return $trueReturnPing
        }
            else {return $falseReturnPing}
        } Catch {Write-Host "$comp failed with $_.ExceptionMessage" -ForegroundColor Yellow}
}
    #stores the return value of the ping function 
    $pingResult = pingFunc -comp $computers

    #Conditional statement that will execute some code 
    if ($pingResult -eq 'True'){
        Write-Host "$computers ping status is good" -ForegroundColor Green

        #command that retrieves the specified registry key from the remote computer. This command will also silence errors 
        Get-RegValue -ComputerName $computers -Key $regKeyToSearch -Recurse -ErrorAction SilentlyContinue | Select-Object ComputerName,Value,Data | Where-Object {$_.Value -eq "DisplayName"} | FT -AutoSize
        
    }
    #if the ping return is false is will let the user know
    if ($pingResult -eq 'False'){
        Write-Host "$computers ping timed out" -ForegroundColor Red -BackgroundColor Black
    }
}

#cycles through a list of computers to perform actions to 
ForEach ($computers in $computer) {

    #This command starts a job in the background and this allows multithreading
    start-job -ScriptBlock $scriptBlock -ArgumentList $computers, $searchRegistryString | Out-Null

    #This while loop prevents the jobs froms exceeding the threshold to conserve system resources
    While($(Get-Job -State Running).Count -ge $maxRunCount) {
        Get-Job | Wait-Job -Any | Out-Null
        }

        #This command will auto remove all completed jobs 
        Get-Job -State Completed | % {
        Receive-Job $_ -AutoRemoveJob -Wait
        }
    }

#Once the foreach loop has ran it will wait until all jobs are completed 
While ($(Get-Job -State Running).Count -gt 0) {
   Get-Job | Wait-Job -Any | Out-Null
}
#This will auto remove the completed jobs
Get-Job -State Completed | % {
   Receive-Job $_ -AutoRemoveJob -Wait
}
#This command removes all jobs from the powershell
Remove-Job *
#Final part of a catch loop 
} catch {Write-Host "$computers failed with error $_.ExceptionMessage"}
