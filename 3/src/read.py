#!/usr/bin/python3

import serial
import sys

ser = serial.Serial()
ser.port = '/dev/ttyUSB0'
ser.baudrate = int(sys.argv[1])
ser.parity = 'N'
ser.stopbits = 1
ser.timeout = 1
ser.xonoff = 0
ser.rtscts = 0
ser.open()

while True:
	b = ser.read()
	if (len(b) > 0):
		print(hex(b[0]), hex(b[0]+1))
		ser.write((b[0]+1,))