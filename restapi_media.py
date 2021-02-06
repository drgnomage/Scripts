#!/usr/bin/env python3

from flask import Flask, request
import requests
import os

app=Flask("RestAPI")
PORT_NUMBER=6001
HOST="0.0.0.0"

@app.route('/')
def hello():
	return("Follow the white rabbit.")


@app.route("/shutdown/", methods=['POST', 'GET'])
def camera():
	PASS = "QEF1632YUH64"
	KEY = request.values.get('KEY')
	TIME = request.values.get('TIME')
	print("KEY: " + str(KEY), sep='\t')
	if KEY == PASS:
		print("Turning off.")
		os.system("echo \"sleep " + str(TIME) + " ; systemctl suspend \" | at now")
		return("Turning off in " + str(TIME) + " seconds.\n")
	elif KEY != PASS:
		return("KEY value is incorrect.\n")
	else:
		return("Something happened, not sure what.\n")

app.run(host=HOST,port=PORT_NUMBER)

