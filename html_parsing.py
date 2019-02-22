import os
from urllib.request import urlopen
from bs4 import BeautifulSoup
import shutil
import fnmatch
from glob import glob
import json
from pprint import pprint
from googlegeocoder import GoogleGeocoder
import urllib.parse

# paste key in
geocoder = GoogleGeocoder("AIzaSyDwUMwOadFZp6g_Vv5vqfej3mBw2-_KYYo")
# html_file = "https://shop.oppomobile.vn/shop"
# html = open(html_file).read()
# soup = BeautifulSoup(html, features="html.parser")

# features="lxml"
page = urlopen('https://shop.oppomobile.vn/shop')
soup = BeautifulSoup(page, features="html.parser")

stores = soup.find_all("a", {"data-address": True})

for store in stores:
	# print (store["data-address"])
	print(urllib.parse.quote(store["data-address"]))
# 	search = geocoder.get(str(store["data-address"]))
	# print(search[0].geometry.location)

query = 'Hellö Wörld@Python'
print(urllib.parse.quote(query))