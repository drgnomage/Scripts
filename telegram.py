#!/usr/bin/env python3

import requests
import sys

link = input('')

send = requests.session()

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 YaBrowser/19.6.1.153 Yowser/2.5 Safari/537.36",
    "Cache-Control": "no-cache, max-age=0",
    "Pragma": "no-cache"
}

def send_photo(chat, link):
	params = {'chat_id': chat_id, 'photo': link}
	response = send.post(url + 'sendPhoto', data=params)
	return response

def send_video(chat, link):
	params = {'chat_id': chat_id, 'video': link}
	response = send.post(url + 'sendVideo', headers=headers, data=params)
	return response

def send_url(chat, link):
	site = requests.get(link)
	params = {'chat_id': chat_id, 'text': site.link}
	response = send.post(url + 'sendMessage', data=params)
	return response

def send_message(chat, link):
	params = {'chat_id': chat_id, 'text': link}
	response = send.post(url + 'sendMessage', data=params)
	return response

if sys.argv[2] == "mine":
	url = "https://api.telegram.org/bot476765644:AAFo0fTJC6ecHA87XhJ1o5YkFI9L-d019fw/"
	chat_id = "103778131"
elif sys.argv[2] == "caturday":
	url = "https://api.telegram.org/bot450362502:AAEiXB-46WqeHGMLDvAbXZ3lIG6TXObi_Us/"
	chat_id = "-163150692"
else:
	print("Please specify a message type and a chat to send to. echo $link ./telegram.py photo mine")

if sys.argv[1] == "photo":
	send_photo(chat_id, link)
elif sys.argv[1] == "video":
	send_video(chat_id, link)
elif sys.argv[1] == "message":
	send_message(chat_id, link)
elif sys.argv[1] == "url":
	send_url(chat_id, link)
else:
	print("Please specify a message type and a chat to send to. echo $link | ./telegram.py photo mine")

