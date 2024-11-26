# Minimal Arduino IDE Alternative

## Overview
This is useful to people who dislike the internet, themselves, and most importantly, ease of use. It is a lightweight, efficient tool that allows for swift development, optimized for the Microsoft Windows platform, designed for the **Windows hater of tomorrow.**

## Requirements
- [Arduino-cli](https://github.com/arduino/arduino-cli/releases)
- [CH340 Driver](https://www.wch-ic.com/download/CH341SER_EXE.html)
- [CP210X Driver](https://www.silabs.com/developer-tools/usb-to-uart-bridge-vcp-drivers)
- [FTDI VCP Driver (CDM213464-FT232RL)](https://ftdichip.com/drivers/vcp-drivers/)

## Hardware Requirements 📟
- USBasp

## Setup
To set up the environment, run the following command in PowerShell:


- > PS C:> make env

## Example

**Change the Makefile** ⬇️




- brd = board name *(FQBN fully qualified board name)*
- Esp32 = esp32:esp32:esp32
- Esp32 - s3 = esp32:esp32:esp32s3
- seeed studio xiao = Seeeduino:samd:seeed_XIAO_m0
- esp8266 = esp8266:esp8266:nodemcuv2
- arduino = arduiono:avr:X
 *here, X is the placeholder for board/chip name uno,nano,mega (refer PS C:> make core for all FQBN)*


- port = Use the PS C:> make avail to see the ports of connected devices *(if any)*
- cuf = kbin for binary and khx to keep intel hex firmware *(except avr boards most all boards use
the binary file format)*
- AVR section just change mcu to 328p or 328pb *(if you change to the PB variant change the brd
(fqbn) to Micro:avr:328)*

- `dev = keep as is [ $(brd):$(cdc) for esp32-s3 as it has some communication device class boogaloo]`


💡ProTip: *Not recommended to change the fuse bits if you don't know what you're doing and i don't know what i was doing when i discovered this information.*

## After setup just run
- > PS C:> make
- > PS C:> make flash

## Makefile options (mentions which ones require an usbasp)

- resolve = library dependency resolver
- clean = wipe all binary
- erase = wipe the chip *(AVR only)*
- burn = flash option for AVR only *(see the burn function comments)*
- boot = burn bootloader AVR only *(depends on the chip but m328, m328p and m328pb are the
same)* [Atmega2560 m2560 support, fuse setting and others]
- check = read lock bits
- core = check available cores
- lib = check installed libraries
- avail = check connected boards
- eval = show AVR chip details
- details = read board details

## General Usage

Write code in the Arduino.ino (file location !!CANNOT!! be changed), put libraries in a separate folder (same directory as the .ino file)

## Warnings ⛑️

*This tool might be useful and fun but if you plan to use this in anything remotely important be
prepared to loose your job, family and sanity. Ciao* 🙃





