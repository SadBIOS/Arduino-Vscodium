# Minimal Arduino IDE Dev Environment

---

### Overview
This is useful to people who dislike the internet, themselves, and most importantly, ease of use. It is a lightweight, efficient tool that allows for swift development, optimized for the Microsoft Windows OS, designed for the **Windows Hater of Tomorrow.**

---

### Requirements
- [arduino-cli](https://github.com/arduino/arduino-cli/releases)
- [CH340 Driver](https://www.wch-ic.com/download/CH341SER_EXE.html)
- [CP210X Driver](https://www.silabs.com/developer-tools/usb-to-uart-bridge-vcp-drivers)
- [FTDI VCP Driver (CDM213464-FT232RL)](https://ftdichip.com/drivers/vcp-drivers/)
- [avrdude](https://github.com/avrdudes/avrdude)
- [VSCodium](https://github.com/VSCodium/vscodium)
- [Arduino Community Extension](https://marketplace.visualstudio.com/items?itemName=vscode-arduino.vscode-arduino-community)
- [Serial Monitor Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-serial-monitor)

---

### Hardware Requirements 📟
- [USBasp](https://www.electronics.com.bd/usbasp-avr-programmer-parts-ic-module-sensor-arduino-transistor-resistor-capacitor-robotics-project-electronics-bangladesh?route=product/product&search=usbasp&category_id=0)
---
### Setup
To set up the environment, run the following command in PowerShell:

```> PS C:> make env```

---

### Example

**Change the Makefile** ⬇️
 _brd_ = board name *(FQBN fully qualified board name).* A few options are given below as I work on these boards.
- ESP32 = ```esp32:esp32:esp32```
- ESP32-S3 = ```esp32:esp32:esp32s3```
- Seeed Studio Xiao (Microchip SAMD21) = ```Seeeduino:samd:seeed_XIAO_m0```
- ESP8266 (LoLin Nodemcu V3) = ```esp8266:esp8266:nodemcuv2```
- Arduino (AVR Core) = ```arduiono:avr:X```

Here, **X** is the placeholder for board/chip name uno,nano,mega _(refer ```PS C:> make core``` for all FQBN)_


- port = Use the ```PS C:> make avail``` to see the ports of connected devices *(if any)*
- cuf = ***kbin*** for binary and ***khx*** to keep intel hex firmware *(except avr boards most all boards use the binary file format)*
- AVR section just change mcu to 328p or 328pb *(if you change to the PB variant change the brd (fqbn) to Micro:avr:328)*
- dev = keep as is [ ```$(brd):$(cdc)``` for esp32-s3 as it has some communication device class boogaloo]

💡ProTip: *Not recommended to change the fuse bits if you don't know what you're doing and i don't know what i was doing when i discovered this information.*

---

### Post Setup Run the Following Commands
```> PS C:> make```

```> PS C:> make flash```

---

### Makefile options (mentions which ones require an usbasp)
- _resolve_ = library dependency resolver
- _clean_ = wipe all binary
- _erase_ = wipe the chip *(AVR only)*
- _burn_ = flash option for AVR only *(see the burn function comments)*
- _boot_ = burn bootloader AVR only *(depends on the chip but m328, m328p and m328pb are the same)* [Atmega2560 m2560 support, fuse setting and others]
- _check_ = read lock bits
- _core_ = check available cores
- _lib_ = check installed libraries
- _avail_ = check connected boards
- _eval_ = show AVR chip details
- _details_ = read board details

---

### General Usage
Write code in the Arduino.ino (file location !!CANNOT!! be changed), put libraries in a separate folder (same directory as the .ino file)

---

### Warnings ⛑️
*This tool might be useful and fun but if you plan to use this in anything remotely important be
prepared to loose your job, family and sanity. Ciao* 🙃
