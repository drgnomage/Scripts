#!/usr/bin/env python3

import sys
sys.path.insert(0, "/home/josh/.python3/")

import signal
import socket
import time
import paho.mqtt.client as mqtt

mqttc = mqtt.Client()
mqttc.connect("192.168.0.1")
mqttc.loop_start()

def signal_handler(sig, frame):
	print('You pressed Ctrl+C!')
	mqttc.publish("media", "offline")
	time.sleep(2)
	sys.exit(0)
signal.signal(signal.SIGINT, signal_handler)
print('Press Ctrl+C')

while True:
	message = "online"
	mqttc.publish("media", "online")
	time.sleep(60)
