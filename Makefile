mcu = m328pb
brd = nano

default:
	arduino-cli compile -e -v -b arduino:avr:$(brd)
	powershell -command ".\cleanup.ps1"

erase:
	avrdude -c usbasp -p $(mcu) -e 

upload:
	avrdude -c usbasp -p $(mcu) -P usb -U flash:w:firmware.hex