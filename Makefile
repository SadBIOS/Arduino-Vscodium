code = Arduino.ino
brd = MiniCore:avr:328			# FQBN (fully qualified board name), example: arduino:avr:nano or esp32:esp32:esp32s3
port = COM5				# check connected boards via device manager or "make avail" !CANNOT BE BLANK!
cuf = khx				# cleanup function (refer to the readme file) !CANNOT BE BLANK!
dev = $(brd)				# remove :$(cdc) for most cases
firmware = $(code).bin			# firmware filename (without extension)
cdc = CDCOnBoot=cdc			# required for esp32s3 communication device class (virtual serial over USB)

# AVR only (get fuse values from boards.txt), change the hex value *:w:0x*:m (the fuse selection in avrdude is very non-intuitive)
mcu = m328pb				# only applicable for the Arduino AVR platform
lfuse = lfuse:w:0xFF:m
hfuse = hfuse:w:0xDA:m
efuse =	efuse:w:0xFD:m
lckbyt = lock:w:0xCF:m 					
pgmr = usbasp
btclk =	93.75				# bit clock (8kHz = 93.75)
brt = 115200				# baud rate

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

burn:	# only one can be uncommented at a time
# add .with_bootloader if bootloader is not required (the following command is for advanced users recommended for bootloader-less systems and the stupid 328pb)
#	avrdude -c $(pgmr) -p $(mcu) -P usb -U flash:w:./firmware/$(code).with_bootloader.hex:i -vvv -B $(btclk) -b $(brt)
# keep the previous line commented and is for normal use (given bootloader exists)
#	arduino-cli upload -p $(port) --verbose --fqbn $(dev) --input-file .\firmware\$(code).with_bootloader.hex
# the next like is the the most stupid line in existance (this is for the native upload keep commented unless you know the chip)
	arduino-cli upload -p $(port) --verbose --fqbn $(dev) --input-file .\firmware\$(code).eep

boot:	# usbasp required (must compile a blank sketch for that board first)
	avrdude -c $(pgmr) -P usb -p $(mcu) -e -vvv -B $(btclk) -b $(brt)
	avrdude -c $(pgmr) -p $(mcu) -P usb -U $(lfuse) -U $(hfuse) $(efuse) -B $(btclk) -b $(brt) -vvv
	avrdude -c $(pgmr) -p $(mcu) -P usb -U flash:w:./firmware/$(code).with_bootloader.hex:i -vvv -B $(btclk) -b $(brt)
	avrdude -c $(pgmr) -p $(mcu) -P usb -U $(lckbyt) -B $(btclk) -b $(brt) -vvv


check:	# usbasp required
	avrdude -c $(pgmr) -p $(mcu) -P usb -B $(btclk) -b $(brt) -U hfuse:r:-:h -U lfuse:r:-:h -U efuse:r:-:h -U lock:r:-:h

erase:	# usbasp required
	avrdude -c $(pgmr) -P usb -p $(mcu) -e -vvv -B $(btclk) -b $(brt)

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
	avrdude -c $(pgmr) -p $(mcu) -vvv

details:
	arduino-cli board details --fqbn $(brd)
