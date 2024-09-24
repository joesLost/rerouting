import googlemaps
import time
import requests
from datetime import datetime
import pandas
import numpy

wb = pandas.open("Reroute Master File")
sh = pandas.

APIkey="AIzaSyAYqmfKga0RMsuC1ddMBDm7SnB4S7os4Sw"

gmaps = googlemaps.Client(APIkey)

url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=Washington%2C%20DC&destinations=New%20York%20City%2C%20NY&units=imperial&key=" + APIkey

payload={origins='3440 3 Mile Rd NW, Grand Rapids, MI 49534, 49534 US', destinations='2030 Seminole Rd Norton Shores 49441'
        }
headers = {}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)
