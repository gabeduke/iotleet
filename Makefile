upload:
	nodemcu-tool upload *.lua

test:
	nodemcu-tool run test.lua

reset:
	nodemcu-tool reset

flash:
	esptool.py write_flash -fm dio 0x00000 firmware.bin

clean:
	esptool.py  erase_flash

terminal:
	nodemcu-tool terminal