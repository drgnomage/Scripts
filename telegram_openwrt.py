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

url = "https://api.telegram.org/bot476765644:AAFo0fTJC6ecHA87XhJ1o5YkFI9L-d019fw/"
chat_id = "103778131"

send_photo(chat_id, link)
