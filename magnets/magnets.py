#!/usr/bin/env python3

import transmissionrpc
import feedparser
import secrets
import requests
import sys


send = requests.session()
feed = feedparser.parse(secrets.feed)
tc = transmissionrpc.Client(secrets.server, port=secrets.port, user=secrets.username, password=secrets.password, timeout=20)
torrents = tc.get_torrents()
number = len(torrents)
magnet_file = secrets.magnet_file


headers = {
	"User-Agent": "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 YaBrowser/19.6.1.153 Yowser/2.5 Safari/537.36",
	"Cache-Control": "no-cache, max-age=0",
	"Pragma": "no-cache"
}

def send_message(message):
	params = {'chat_id': secrets.telegram_chat_id, 'text': message}
	response = send.post(secrets.telegram_bot + 'sendMessage', data=params)
	return response

def check_magnet_file(magnet_file):
	try:
		file = open(magnet_file)
		file.close()
	except IOError:
		print('File is not accessible, creating now.')
		file = open(magnet_file, "x")
		file.close()

def check_transmission(torrents, number):
	count = 0
	while count < number:
		print (torrents[count].status + ":\t" + torrents[count].name + "\n")
		count = count+1

def remove_complete(torrents, number):
	count = 0
	while count < number:
		status = torrents[count].status
		if status == "stopped":
			message = "Removing:\t" + torrents[count].name + "\n"
			print (message)
			send_message(message)
			tc.stop_torrent(torrents[count].hashString)
			tc.remove_torrent(torrents[count].hashString)
		count = count+1

def add_torrent(tc, torrent, torrent_name):
	message = "Adding:\t" + torrent_name + "\n"
	print (message)
	tc.add_torrent(torrent)
	send_message(message)

def check_torrent(magnet_file, torrent):
	with open(magnet_file) as file:
		if torrent not in file.read():
			print ("Torrent not found:\t" + torrent + "\n")
			return True

def write_to_file(magnet_file, torrent):
	file = open(magnet_file, "a")
	file.write(torrent + "\n")
	file.close()

def pull_feed(feed, tc, magnet_file):

	number = len(feed)
	count = 0

	while count < number:
		print (feed.entries[count].title + ":\n\t" + feed.entries[count].link + "\n")
		torrent = feed.entries[count].link
		torrent_name = feed.entries[count].title
		count = count+1
		print ("Count:", count, ", Number:", number)

		if check_torrent(magnet_file, torrent):
			add_torrent(tc, torrent, torrent_name)
			write_to_file(magnet_file, torrent)


if __name__ == '__main__':
	check_magnet_file(magnet_file)
	check_transmission(torrents, number)
	remove_complete(torrents, number)
	pull_feed(feed, tc, magnet_file)
