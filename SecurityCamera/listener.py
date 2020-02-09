#!/usr/bin/env python3
import json
import requests
import time
import datetime
import os

import paho.mqtt.client as mqtt

MQTT_PORT = 1883
MQTT_TOPIC = "/merakimv/Q2FV-K7QZ-K7B5/raw_detections"
MERAKI_API_KEY = "96850833f85705851d736e34914eea6db9360280"
ROOM_ID = ""

MOTION_ALERT_PEOPLE_COUNT_THRESHOLD = 1
_TRIGGERED = False
_MONITORING_MESSAGE_COUNT = 0
_MONITORING_PEOPLE_TOTAL_COUNT = 0
SERIAL_NO = "Q2FV-K7QZ-K7B5"
NETWORK_ID = "L_575897802350005363"


def collect_information(payload):
    global _MONITORING_MESSAGE_COUNT, _MONITORING_PEOPLE_TOTAL_COUNT, _TRIGGERED
    # if _TRIGGERED:
    _MONITORING_MESSAGE_COUNT = _MONITORING_MESSAGE_COUNT + 1

    # if payload >= MOTION_ALERT_PEOPLE_COUNT_THRESHOLD:
    notify(SERIAL_NO)
    # reset
    if _MONITORING_MESSAGE_COUNT > 7:
        _MONITORING_MESSAGE_COUNT = 0
        print("reset")
        # _MONITORING_PEOPLE_TOTAL_COUNT = 0
        # _TRIGGERED = False

    # if payload > MOTION_ALERT_PEOPLE_COUNT_THRESHOLD:
    #     print("gets here")
    #     _TRIGGERED = True
    #     print("payload : " + str(payload))


def notify(serial_number):
    url = "https://api.meraki.com/api/v0/networks/{1}/cameras/{0}/snapshot".format(serial_number, NETWORK_ID)
    time_stamp = str(time.time()).split(".")[0]
    readable = datetime.datetime.fromtimestamp((int(time_stamp))).isoformat() + "Z"
    time.sleep(60)

    print(readable)
    payload = "{\n\t\"timestamp\": \"" + readable + "\"\n}"
    headers = {
        'X-Cisco-Meraki-API-Key': MERAKI_API_KEY,
        'Content-Type': 'application/json'
    }
    response = requests.request("POST", url, headers=headers, data=payload)
    print(response.text.encode('utf8'))

    if response.status_code//100 == 2:
        print("Success")
        print(response.text.encode('utf8'))

        link = response.url
        file = readable + ".jpg"
        output = open(file, "wb")
        output.write(link.read())
        # os.rename(file, "../SecurityCamera/snapshots/" + file)
        output.close()


def on_connect(client1, userdata, flags, rc):
    print("Connected with result code " + str(rc))
    client.subscribe(MQTT_TOPIC)


def on_message(client1, userdata, msg):
    print("Received message")
    payload = json.loads(msg.payload.decode("utf-8"))
    collect_information(payload)


# main
client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message
client.connect("206.189.31.166", MQTT_PORT, 60)
client.loop_forever()
