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


@app.route("/music/", methods=['POST', 'GET'])
def camera():
	PASS = "flibble"
	URL = request.values.get('URL')
	KEY = request.values.get('KEY')
	print("URL: " + str(URL), "KEY: " + str(KEY), sep='\t')
	if URL is not None and KEY == PASS:
		print("Playing: " + URL)
		os.system("mpv --no-video --really-quiet " + URL)
		return("Played: " + URL + "\n")
	elif URL is not None and KEY != PASS:
		return("KEY value is incorrect.\n")
	else:
		return("No valid URL found.\n")

app.run(host=HOST,port=PORT_NUMBER)

