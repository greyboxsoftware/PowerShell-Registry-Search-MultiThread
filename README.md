# PowerShell-Registry-Search-MultiThread

This script is used to ping and search in remote PC registry for a specified value that you set in the initial start up of the script. This script ustilizes multi-threading to execute 10 jobs at the same time then executes another jobs once one is finished. So with this model you can accomplish a great deal in a very short time and as a network/system administrator you can appreciate this. 

Some things to note are the following

- You must import the PSRemoteRegistry module into your PowerShell.


    https://psremoteregistry.codeplex.com/

- Due to the newer PowerShell version and the outdated scripts you must make a few changes to the PSRemoteRegistry.psd1 file that is located (see the PSRemoteRegistry.psd1 file here for a reference) 


    c:\windows\system32\windowspowershell\v1.0\modules\PSRemoteRegistry

INSTRUCTIONS:
    
    - Copy and Paste a list of computers inside a text file and save it anywhere on your computer
    - First prompt will ask you for the text file and its path
        - ex.   c:\temp\testComputer.txt
    - Second prompt will ask you for the key you are searching for 
        - ex.    SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\etc...
    - No time for coffee because this script runs fast :) 
