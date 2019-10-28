#!/usr/bin/python3

import tarfile
import sys
import os
import logging
import time
import datetime

time = time.strftime("%d-%m-%Y")
tar = 'backup' + time + '.tar.gz', 'w:gz'

logging.basicConfig(filename='backup_tar.log', level = logging.DEBUG)

logging.info('Checking to see if backup-%(asctime)s.zip exists')

if os.path.exists(tar):
    logging.info("Backup directory exists.")
    try:
        with tarfile.open(tar) as archive:
            archive.add('/home/josh/Documents')
            archive.add('/etc')
    except:
        err = sys.exc_info()
        logging.error("Unable to append backup")
        logging.error("Error Num: " + str(err[1].args[0]))
        logging.error("Error Msg: " + err[1].args[1])
        sys.exit()

else:
    logging.info("Creating backup")
    try:
        zip_file = zipfile.ZipFile("backup-" + time + ".zip", 'w')
        err = sys.exc_info()
    except:
        logging.error('Unable to create backup.zip')
        logging.error("Error Num: " + str(err[1].args[0]))
        logging.error("Error Msg: " + err[1].args[1])
        sys.exit()
logging.info("Adding test.txt to backup")

try:
#    zip_file.write('test.txt', 'test.txt', zipfile.ZIP_DEFLATED)
    with tarfile.open('backup' + time + '.tar.gz', 'w:gz') as archive:
        archive.add('/home/josh/Documents')
        archive.add('/etc')
except:
    err = sys.exc_info()
    logging.error("Unable to append backup")
    logging.error("Error Num: " + str(err[1].args[0]))
    logging.error("Error Msg: " + err[1].args[1])

zip_file.close

