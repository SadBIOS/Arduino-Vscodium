$root = Get-Location
Get-ChildItem | ForEach-Object {
    if ($_.Extension -like '.hex') {
        Remove-Item -Path $root\*.hex
    }
}
Set-Location -Path '.\build\'
$sbdir = Get-ChildItem
Set-Location -Path $sbdir.FullName
Get-ChildItem | ForEach-Object {
    if ($_.Extension -like '.eep' -or $_.Extension -like '.elf' -or $_.Extension -like '.bin') {
        Write-Host "Removing Item: $($_.Name)"
        Remove-Item $_.FullName
        Start-Sleep -Milliseconds 10
    }
}
$file = Get-ChildItem | Where-Object Name -NotLike '*with_bootloader*'
Move-Item -Path $file.FullName -Destination $root
Set-Location $root
Remove-Item -Path .\build -Recurse -Force
$output = Get-ChildItem | Where-Object Extension -Like '.hex'
Rename-Item -Path $output.FullName -NewName 'firmware.hex'