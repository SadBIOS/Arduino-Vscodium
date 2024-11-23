mcu = m328p				# only applicable for the Arduino AVR platform
OEM = nano				# board name also applicable for Arduino AVR platform
brd = esp32:esp32:esp32s3		# FQBN (fully qualified board name)
code = Arduino.ino
firmware = $(code).bin			# firmware filename (without extension)
port = COM12				# check connected boards via device manager or "make avail" !CANNOT BE BLANK!
cuf = kbin				# cleanup function (refer to the readme file) !CANNOT BE BLANK!
cdc = :CDCOnBoot=cdc			# required for esp32s3 communication device class (virtual serial over USB)
dev = $(brd):$(cdc)			# remove :$(cdc) for most cases

default:
	powershell -command ".\runtime\cleanup.ps1 nuke"
	arduino-cli compile --verbose --fqbn $(brd) $(code) --output-dir .
	powershell -command ".\runtime\cleanup.ps1 $(cuf)"
	arduino-cli board list

clean:
	powershell -command ".\runtime\cleanup.ps1 nuke"

resolve:
	powershell -command ".\runtime\resolver.ps1"

flash:
	arduino-cli upload -p $(port) --verbose --fqbn $(dev) --input-file .\firmware\$(firmware)

burn:
	avrdude -c usbasp -p $(mcu) -P usb -U flash:w:./firmware/$(code).hex:i -vvv -B 1

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

eval:
	avrdude -c usbasp -p $(mcu) -vvv

details:
	arduino-cli board details --fqbn $(brd)
