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
function nuke {
    Write-Warning "Removing all firmware, linkers, eeprom data and debugger map files"
    $root = Get-Location
    $extensions = @('*.eep', '*.hex', '*.bin', '*.elf', '*.map')
    &$nopass
}

function keep_hex {
    Write-Warning "Removing all files except intel hex"
    $root = Get-Location
    $extensions = @('*.eep', '*.bin', '*.elf', '*.map')
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
        nuke
    }
    "khx" {
        keep_hex
    }
    "kbin" {
        keep_bin
    }
    default {
        Write-Warning "No function specified, doing nothing :)"
    }
}