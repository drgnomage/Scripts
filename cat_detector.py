#!/usr/bin/env python3

import requests
import json
import os
import io
import base64
from PIL import Image
import sys

home=os.getenv("HOME")

API_KEY=(open(home+"/.aws/API_KEY", "r").read().strip())
#API_KEY="pbd93ELLTv3qe0FU9bkIA7ezLZBg2dxA51c33T3n"
#API_URL="https://ha4hkn976g.execute-api.eu-west-2.amazonaws.com/A"
API_URL=(open(home+"/.aws/API_URL", "r").read().strip())



def customJSON(obj):
    d = obj.__dict__
    for x in d:
        dx = d[x]
        if(type(dx) is int):
            continue
        if(type(dx) is str):
            continue
        if(type(dx) is list):
            for i in range(0, len(dx)):
                dx[i] = customJSON(dx[i])
            continue
        if(dx is None):
            continue

        d[x] = customJSON(d[x])
        print("custom=", d[x])

    return d

class ImageRequest:
    imageBytes=None
    imageURL=None
    confidence=0
    bucketFilename=None
    bucketFolder=None

    def __init__(self, bytes, confidence):
        self.confidence=confidence
        self.imageBytes=bytes

def readImage(filename):
    file=open(filename, "rb")
    data=file.read()
    data = resizeImage(data)
    encoded=base64.b64encode(data).decode()
    return encoded

def isImage(filename):
    if(filename.endswith("png")):
        return True
    elif(filename.endswith("jpeg")):
        return True
    elif(filename.endswith("jpg")):
        return True

def resizeImage(image):
    im = Image.open(io.BytesIO(image))
    size = [1024,1024]

    w,h = im.size
    if(w < size[0]):
        size[0] = w
    if(h < size[1]):
        size[1] = h

    im.thumbnail(size, Image.ANTIALIAS)

    imgByteArr = io.BytesIO()
    im.save(imgByteArr, format='PNG')
    imgByteArr = imgByteArr.getvalue()
    return imgByteArr

def process(filename):

    results = []

    if(os.path.isfile(filename)):
        if(not isImage(filename)):
            return None

        data = readImage(filename)

        request = ImageRequest(data, 50)
        headers = {"accept":"application/json","Content-Type":"application/json", "x-api-key":API_KEY}

        payload=json.dumps(customJSON(request))
        response = requests.post(API_URL, headers=headers, data=payload)
        loaded = json.loads(response.content)
        print(loaded)

    elif(os.path.isdir(filename)):
        for file in os.listdir(filename):
            out = process(filename+"/"+file)
            if(not out is None):
                results.append(out)

    else:
        print("Error: File not found:"+filename)
        return None

    return results




def main():

    print("url="+API_URL)
    print("key="+API_KEY)

    if(len(sys.argv) > 1):
        location=sys.argv[1]
    else:
        location=input("Please give a location::")

    if(location is None or location == ""):
        return
    process(location)

main()
