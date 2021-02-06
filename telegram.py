#!/usr/bin/env python3

import requests
import sys
import secrets

if len(sys.argv) < 2:
	print("Please enter message:")
	message = input('')
else:
	message = sys.argv[1]

send = requests.session()
url = secrets.telegram_url
chat_id = secrets.telegram_chat_id

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 YaBrowser/19.6.1.153 Yowser/2.5 Safari/537.36",
    "Cache-Control": "no-cache, max-age=0",
    "Pragma": "no-cache"
}

def send_message(chat, message):
    params = {'chat_id': chat_id, 'text': message}
    response = send.post(url + 'sendMessage', data=params)
    return response

if __name__ == "__main__":
    send_message(chat_id, message)
