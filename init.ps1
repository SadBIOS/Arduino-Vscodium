#more functionality shall be added to this please refer to the Arduino Automator repository
Clear-Host
$promptMessage = "arduino-cli setup tool by SadBIOS"
try {
    $output = arduino-cli version
} catch {
    Write-Host "arduino-cli command not found. Please add it to the system environment variables and try again."
    exit
}
Write-Host $promptMessage
Start-Sleep -Milliseconds 5000
$commands = @(
    "config init",
    "core update-index",
    "core install arduino:avr",
    "core install esp8266:esp8266 --additional-urls=http://arduino.esp8266.com/stable/package_esp8266com_index.json",
    "core install esp32:esp32 --additional-urls=https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_dev_index.json",
    "core install Seeeduino:samd --additional-urls=https://files.seeedstudio.com/arduino/package_seeeduino_boards_index.json"
)
foreach ($command in $commands) {
    try {
        Write-Host "Running: arduino-cli $command"
        $args = $command -split ' '
        & arduino-cli @args
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