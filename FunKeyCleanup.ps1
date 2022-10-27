# This is a short script to remove everything that comes in the console directories on FunKey OS by default
# To use this script, place it in the root of the FunKey directory (the folder where you see all the console directories), right click it, hit "Run with PowerShell"
# Obviously there is much more that could be added to this, but it would be severe overkill for what the end goal is

# Variables
$cleanupCheck = Read-Host "Are you sure you want to clean out the default included game set? (y/n)"
$dirs = @("Atari Lynx", "Game Boy", "Game Boy Advance", "Game Boy Color", "Game Gear", "Neo Geo Pocket", "NES", "PCE-TurboGrafx", "PS1", "Sega Genesis", "Sega Master System", "SNES", "WonderSwan")
$biosFiles = @()
$files = @()
$location = Get-Location

# Set location so that Get-ChildItem actually works on $dirs since it's not using full paths
Set-Location $location

# Check if the user actually wants to run the script (y)
if ($cleanupCheck.ToLower() -eq "y") {
    foreach($dir in $dirs){
        Write-Host "`n`nNow cleaning the $dir directory..." -ForegroundColor Green
        Write-Host "Files Removed:"
        $files += Get-ChildItem -Path $dir
        foreach($file in $files){
            if ($null -ne (Get-ChildItem -Path $file)) {
                $biosFiles += Get-ChildItem -Path $file
                 foreach($biosFile in $biosFiles){
                    Remove-Item -Path $biosFile -Force
                    Write-Host "$biosFile"
                }
                $biosFiles = @()
            }
            else {
                Remove-Item -Path $file -Force
                Write-Host "$file"
            }
        }
        $files = @()
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

