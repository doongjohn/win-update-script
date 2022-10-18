$ErrorActionPreference = "Stop" # stop script on the first error

$location = "$env:USERPROFILE\apps\vscode\"
Set-Location $location

Write-Output '[script] removing all files in '$location
fd --maxdepth=1 --exclude=data | Remove-Item -Force -Recurse

$url = 'https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-archive'

Write-Output '[script] downloading: '$url
Invoke-WebRequest -Uri "$url" -OutFile 'vscode.zip'

Write-Output '[script] extracting'
Expand-Archive 'vscode.zip' .\ && Remove-Item 'vscode.zip'

Write-Output '[script] complete'
