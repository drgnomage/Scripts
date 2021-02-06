#!/usr/bin/env python3

from datetime import datetime, date
import json
import os
import sys
import signal
import pandas as pd
import matplotlib.pyplot as plt

def signal_handler(signal, frame):
        print ('\n\nQuitting . . . \n')
        sys.exit(0)
signal.signal(signal.SIGINT, signal_handler)

script_dir = os.path.dirname(__file__)
rel_path = "steps.json"
abs_file_path = os.path.join(script_dir, rel_path)
day_of_year = datetime.now().timetuple().tm_yday
yesterday = day_of_year - 1
steps_daily = 8250


def truncate(n, decimals=0):
	multiplier = 10 ** decimals
	result = int(n * multiplier) / multiplier
	return int(result)

def step_count(data, day, steps):
	#print (int(data[str(day)]))
	try:
		steps_of_day = int(data[str(day)])
	except:
		steps_of_day = None

	if steps_of_day is None:
		steps_of_day = int(input("Steps on day:\t" + str(day) + "\n\n\t"))
		data[str(day)] = steps_of_day
		with open(abs_file_path, 'w') as json_file:
			json.dump(data, json_file)

		#print (steps_of_day)
	steps = steps + steps_of_day
	return steps

def load_data(abs_file_path):
	with open(abs_file_path) as f:
		data = json.load(f)
	return data

def print_today(data, day_of_year, abs_file_path):
	# Try to print the day of the year and step count and ask for step count if this fails
	try:
		print ("Day:\t\t" + str(day_of_year))
		print ("Steps:\t\t" + str(data[str(day_of_year)]))
	except:
		data[str(day_of_year)] = int(input("Steps on day:\t" + str(day_of_year) + "\n\n\t"))
		with open(abs_file_path, 'w') as json_file:
			json.dump(data, json_file)

def edit(data, day_of_year):
	data[str(day_of_year)] = int(input("Steps on day:\t" + str(day_of_year) + "\n\n\t"))
	with open(abs_file_path, 'w') as json_file:
		json.dump(data, json_file)
	return data[str(day_of_year)]

def add(data, day_of_year):
	try:
		current = data[str(day_of_year)]
	except:
		current = 0

	addition = int(input("Steps today:\t" + str(current) + "\nSteps to add:\t"))
	data[str(day_of_year)] = current + addition
	with open(abs_file_path, 'w') as json_file:
		json.dump(data, json_file)
	return data[str(day_of_year)]

def make_graph(data):
	data_arr = []
	days = {}

	for day in data:
		converted = {"Day": day, "Steps": data[day]}
		data_arr.append(converted)
	days["day"] = data_arr

	df = pd.DataFrame.from_dict(days["day"])
	print (df)
	#plt.figure(figsize=(15,4))
	df.plot(x="Day", y="Steps")
	plt.title("Step Count Day " + str(day_of_year), fontsize = 14, fontweight ='bold')
	plt.xlabel("Days")
	plt.ylabel("Steps")
	graph_name = "Step_Count_" + str(day_of_year) + ".png"
	plt.savefig(graph_name, facecolor='#ededed', edgecolor='#dedede', dpi=150)

if __name__ == '__main__':
	data = load_data(abs_file_path)

	try:
		mode = sys.argv[1]
	except:
		mode = None

	if mode == "edit":
		for day in range(day_of_year - 6, day_of_year + 1):
			try:
				print ("Day: " + str(day) + " - " + str(data[str(day)]))
			except:
				print ("Day: " + str(day) + " - 0")
		day_to_edit = input("Day to edit: \n\n\t")
		data[str(day_to_edit)] = edit(data, day_to_edit)
		exit(0)
	elif mode == "add":
		data[str(day_of_year)] = add(data, day_of_year)
	elif mode == "enter":
		data[str(day_of_year)] = edit(data, day_of_year)
	elif mode == "graph":
		make_graph(data)
		exit(0)

	#print (data)
	# Add up all the steps
	steps = 0
	for day in range(1, day_of_year + 1):
		steps = step_count(data, day, steps)

	print_today(data, day_of_year, abs_file_path)
	print ("Total steps:\t" + str(steps))
	print ("Steps needed:\t" + str(steps_daily * day_of_year))
	steps_average = int(steps / day_of_year)
	print ("Average steps:\t" + str(steps_average))
	if data[str(yesterday)] >= (steps_daily * 1.5):
		previous = 2.5
	elif data[str(yesterday)] >= steps_daily:
		previous = 2
	elif data[str(yesterday)] >= (steps_daily * 0.8):
		previous = 1.5
	else:
		previous = 1

	steps_required = steps_daily * day_of_year - steps
	if steps_required <= 0:
		previous = 4

	extra_steps = steps_required / previous
	steps_tomorrow = int(extra_steps + steps_daily)
	print ("Steps tomorrow:\t" + str(truncate(steps_tomorrow, -3)))
