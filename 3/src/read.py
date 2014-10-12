#!/usr/bin/python3

import serial

ser = serial.Serial('/dev/ttyUSB0', 9600, timeout=1)

while True:
	
	print(ser.read())
