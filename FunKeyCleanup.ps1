# This is a short script to remove everything that comes in the console directories on FunKey OS by default
# To use this script, place it and the FileList.txt file in the root of the FunKey directory (the folder where you see all the console directories), right click it, hit "Run with PowerShell"
# Obviously there is much more that could be added to this, but it would be severe overkill for what the end goal is

# Variables
$cleanupCheck = Read-Host "Are you sure you want to clean out the default included game set? (y/n)"
$files = Get-Content -Path "FileList.txt"

# Check if the user actually wants to run the script (y)
if ($cleanupCheck.ToLower() -eq "y") {
    Write-Host "`nFiles Removed:" -ForegroundColor Green
    foreach ($file in $files) {
        Remove-Item -Path $file -Force
        Write-Host "$file"
    }
}

# Check if the user decided not to run the script (n)
elseif ($cleanupCheck.ToLower() -eq "n") {
    Write-Host "You decided to not run the FunKey Cleanup! Script exiting..."
}

# Check if user input for #cleanupCheck was bad (not y/n)
else {
    "Input not valid: Script restarting..."
    .\"FunKeyCleanup.ps1"
}
