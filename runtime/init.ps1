$trigger = $args[0]
switch ($trigger) {
    "setup"  {
        Clear-Host
        $promptMessage = "arduino-cli setup tool by SadBIOS"
        try {
            arduino-cli version > $null
        } catch {
            Write-Host "arduino-cli command not found. Please add it to the system environment variables and try again."
            exit
        }
        Write-Host $promptMessage
        Start-Sleep -Milliseconds 5000
        $commands = @(
            "config init",
            "core update-index",
            "lib update-index",
            "core install arduino:avr",
            "core install esp8266:esp8266 --additional-urls=http://arduino.esp8266.com/stable/package_esp8266com_index.json",
            "core install esp32:esp32 --additional-urls=https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_dev_index.json",
            "core install Seeeduino:samd --additional-urls=https://files.seeedstudio.com/arduino/package_seeeduino_boards_index.json"
        )
        foreach ($command in $commands) {
            try {
                Write-Host "Running: arduino-cli $command"
                $crf = $command -split ' '
                & arduino-cli @crf
            } catch {
                Write-Host "Error occurred while running: arduino-cli $command"
                Write-Host $_.Exception.Message
            }
        }
        Write-Host "Setup Complete!"
        Start-Sleep -Milliseconds 5000
        Write-Host "`nInstalled Cores and Available Boards:`n"
        try {
            arduino-cli core list
        } catch {
            Write-Host "Error retrieving installed cores."
        }
    }
    "corestat"   {
        Write-Host "`n`nMicroship AVR Platform" -ForegroundColor Cyan
            arduino-cli board listall | grep 'avr' | sort
        Write-Host "`n`nEspressif ESP32 Platform" -ForegroundColor Cyan
            arduino-cli board listall | grep 'esp32' | sort
        Write-Host "`n`nEspressif ESP8266 Platform" -ForegroundColor Cyan
            arduino-cli board listall | grep 'esp8266' | sort
        Write-Host "`n`nMicrochip SAMD Platform" -ForegroundColor Cyan
            arduino-cli board listall | grep 'samd' | sort
            Write-Host "`n`n"
        Write-Host "`n`nCore Summary" -ForegroundColor Cyan
            arduino-cli core list | sort
            Write-Host "`n`n"
    }
    "libstat"{
        Write-Host "`nShowing List of Libraries Installed`n"
        arduino-cli lib list | awk -F'user' '{print $1}' | awk -F'Location' '{print $1}'
    }
    "lib_build"{
        Write-Host "`nBuilding Local Library Cache"
        arduino-cli lib search * | grep 'Name: \"' | awk -F'\"' '{print $2}' | sort | uniq > lib.txt
        $libcount = Get-Content .\lib.txt | wc -l
        Write-Host "`nDone Caching $libcount Library Names!`n"
    }
    Default {
        Write-Error "function called with unexpected argument"
    }
}