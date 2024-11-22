mcu = 						# only applicable for the Arduino AVR platform
OEM = 						# board name also applicable for Arduino AVR platform
brd = esp32:esp32:esp32		# FQBN (fully qualified board name)
code = Arduino.ino
firmware =					# firmware filename (without extension)
port = 						# check connected 
cuf = 						# cleanup function (refer to the readme file)

default:
	powershell -command ".\runtime\cleanup.ps1 nuke"
	arduino-cli compile --verbose --fqbn $(brd)  $(code) --output-dir .
	powershell -command ".\runtime\cleanup.ps1 $(cuf)"
	arduino-cli board list

clean:
	powershell -command ".\runtime\cleanup.ps1 nuke"

resolve:
	powershell -command ".\runtime\resolver.ps1"

flash:
	arduino-cli upload -p $(port) --verbose --fqbn $(brd) --input-file $(firmware)

boot:
	arduino-cli burn-bootloader --fqbn arduino:avr:$(OEM) --programmer usbasp -vvv

burn:
	avrdude -c usbasp -p $(mcu) -P usb -U flash:w:$(firmware).hex:i -vvv -B 1

erase:
	avrdude -c usbasp -P usb -p $(mcu) -e -vvv

env:
	powershell -command ".\runtime\init.ps1 setup"
	powershell -command ".\runtime\init.ps1 lib_build"

core:
	powershell -command ".\runtime\init.ps1 corestat"

lib:
	powershell -command ".\runtime\init.ps1 libstat"

avail:
	arduino-cli board list
