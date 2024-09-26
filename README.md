Arduino IDE replacement (better comfort/ergonomics) using VSCodium. A minimal blink sketch, Makefile and cleanup script is provided as an example (for the Arduino Nano, Atmega328PB version).



**Dependencies:**

1. [MinGW-w64 Toolchain](https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-posix/seh/) (download the x86_64-posix-seh .7z archive)
2. [VSCodium](https://github.com/VSCodium/vscodium)
3. [Serial Monitor Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-serial-monitor)
4. [Arduino Extension](https://marketplace.visualstudio.com/items?itemName=vsciot-vscode.vscode-arduino)
5. [C/C++ Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
6. [arduino-cli](https://github.com/arduino/arduino-cli)
7. [avrdude](https://github.com/avrdudes/avrdude)



**Process:**

1. rename mingw32-make.exe to make.exe
2. add MinGW64/bin, arduino-cli and avrdude to Environment Variable
3. run following commands
   * arduino-cli core install arduino:avr
   * arduino-cli config init
4. install extensions and enable Arduino: Use Arduino Cli check-box at the bottom of extension settings
5. select the board and verify the code to initialize everything



**Notes:** Additional USB drivers may be required. Use *Zadig* if needed. The name of the sketch must be same as the parent folder.
