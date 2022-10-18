$ErrorActionPreference = "Stop" # stop script on the first error

$location = "$env:USERPROFILE\apps\git\"
Set-Location $location

Write-Output '[script] removing all files in '$location
fd --maxdepth=1 | Remove-Item -Force -Recurse

$repo = 'git-for-windows/git'
$version = $(gh --repo=$repo release list --exclude-drafts | rg -m=1 'Latest' | rg -o -m=1 'v[^\s]+')
$asset = $(gh --repo=$repo release view $version | rg -o -m=1 'MinGit[\d\.\-]+64-bit.zip')

Write-Output '[script] downloading: '$asset
gh --repo=$repo release download "$version" -p="$asset"

Write-Output '[script] extracting'
Expand-Archive "$asset" .\ && Remove-Item -Force "$asset"

Write-Output '[script] complete'
