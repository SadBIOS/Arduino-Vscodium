if (-not (Test-Path -Path '.\firmware')) {
    Write-Host 'Creating Firmware Folder' -ForegroundColor Cyan
    New-Item -Path '.\firmware' -ItemType Directory
}
else {
    Write-Host 'Firmware folder exists. No action required' -ForegroundColor DarkMagenta
}
$nopass = {
    $foundFiles = $false
    foreach ($ext in $extensions) {
        $files = Get-ChildItem -Path $root -Filter $ext -File
        if ($files) {
            $foundFiles = $true
            $files | Remove-Item -Force
            Write-Host "Deleted files with extension $ext"
        }
    }
    if (-not $foundFiles) {
        Write-Warning "No such file exists. Exiting :)"
        exit
    }
}
$massmv = {
    Get-ChildItem -Path . -Filter '*.hex' | Move-Item -Destination '.\firmware'
    Get-ChildItem -Path . -Filter '*.bin' | Move-Item -Destination '.\firmware'
}
$flush = {
    Get-ChildItem -Path '.\firmware\' | Remove-Item
}
function nuke {
    Write-Warning "Removing all firmware, linkers, eeprom data and debugger map files"
    $root = Get-Location
    $extensions = @('*.eep', '*.hex', '*.bin', '*.elf', '*.map')
    &$nopass
}

function keep_hex {
    Write-Warning "Removing all files except intel hex"
    $root = Get-Location
    $extensions = @('*.eep', '*.bin', '*.elf', '*.map', '*.with_bootloader.hex')
    &$nopass
}

function keep_bin {
    Write-Warning "Removing all files except binaries"
    $root = Get-Location
    $extensions = @('*.eep', '*.hex', '*.elf', '*.map')
    &$nopass
}

$trigger = $args[0]

switch ($trigger) {
    "nuke" {
        &$flush
        nuke
    }
    "khx" {
        &$flush
        keep_hex
        &$massmv
    }
    "kbin" {
        &$flush
        keep_bin
        &$massmv
    }
    default {
        Write-Warning "No function specified, doing nothing :)"
    }
}
