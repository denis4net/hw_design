#!/usr/bin/python3

import serial

ser = serial.Serial('/dev/ttyUSB0', 9600, timeout=1)

while True:
	b = ser.read()
	if (len(b) > 0):
		print(hex(b[0]))
		ser.write(b)
		
