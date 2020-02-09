import difflib
import json
from flask import Blueprint, Response, request
import requests
import http.client, urllib.request, urllib.parse, urllib.error, base64

barcode = Blueprint('barcode', __name__)

food_db_key = "ad08b45030aa9122d39cbb6efb154f87"
food_db_id = "78938bf0"

eanToken = 'cee7b3d1236f7076c16d0f9a02d4e5'

# headers = {
#   'Content-Type': 'application/json',
#   'Accept': 'application/json'
# }

test = """[{"ean":"7622210740489","name":"Belvita Milk and Cereal Biscuits 12 Pack 540G","categoryId":"0","categoryName":"Unknown"}] """

def getResultJSON(ean, name, price, imageURL, nutrients, lowCalAlt, lowFatAlt, lowCarbAlt):
        return {"ean": ean,
        "name": name,
        "price": price,
        "imageURL": imageURL,
        "nutrients": nutrients,
        "lowCalAlt": lowCalAlt,
        "lowFatAlt": lowFatAlt,
        "lowCarbAlt": lowCarbAlt}

@barcode.route('/ean/<ean>')
def get_product(ean):
    # product = getInfo(id)
    product = json.loads(test)
    name = product[0].get("name")
    # print(obj['name'])
    price, imageURL = getPrice(name.lower())
    foodData = getFoodInfo(name.lower())
    # getNutrients(foodData, name)
    nutrients, allAlts = getNutrients(foodData, name)
    lowCalAlt, lowFatAlt, lowCarbAlt = getAlts(allAlts)

    result = getResultJSON(ean, name, price, imageURL, nutrients, lowCalAlt, lowFatAlt, lowCarbAlt)
    return json.dumps(result)


def getAlts(allAlts):
    (lowestCal, labelCal) = (getCals(allAlts[0]), allAlts[0])
    (lowestFat, labelFat) = (getFat(allAlts[0]), allAlts[0])
    (lowestCarbs, labelCarbs) = (getCarbs(allAlts[0]), allAlts[0])
    for alt in allAlts[1:]:
        if getCals(alt) < lowestCal:
            lowestCal = getCals(alt)
            labelCal = getLabel(alt)
        if getFat(alt) < lowestFat:
            lowestFat = getFat(alt)
            labelFat= getLabel(alt)
        if getCarbs(alt) < lowestCarbs:
            lowestCarbs = getCarbs(alt)
            labelCarbs = getLabel(alt)

    return (lowestCal, labelCal), (lowestFat, labelFat), (lowestCarbs, labelCarbs)


def getCals(food):
    return food['food']['nutrients']['ENERC_KCAL']

def getFat(food):
    return food['food']['nutrients']['FAT']

def getCarbs(food):
    return food['food']['nutrients']['CHOCDF']

def getNutrients(foodData, name):
    possibleMatches = foodData.get('hints')
    bestMatchLabel = difflib.get_close_matches(name.lower(), map(getLabel, possibleMatches), n=1, cutoff=0.5)[0]
    print(bestMatchLabel)
    for m in possibleMatches:
        print(getLabel(m))
        if getLabel(m).lower() == bestMatchLabel:
            bestMatch = m
            print("found")
            possibleMatches.remove(m)
            print(bestMatchLabel)
            print(possibleMatches)
            return bestMatch['food']['nutrients'], possibleMatches

def getLabel(x):
    return x['food']['label']


def getInfo(ean):
    params = 'token=' + eanToken + '&op=barcode-lookup&format=json&ean='+ean
    try:
        conn = http.client.HTTPSConnection('api.ean-search.org')
        conn.request("GET", "/api?%s" % params)
        response = conn.getresponse()
        data = response.read()
        conn.close()
        return data
    except Exception as e:
        print("[Errno {0}] {1}".format(e.errno, e.strerror))

def getPrice(name):
    headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
    }
    name.replace(" ", "%20")
    resp = requests.get('https://api.upcitemdb.com/prod/trial/search?s='+name, headers=headers)
    res = json.loads(resp.text)['items'][0]
    price = res['offers'][0]['price']
    imageURL = res['images'][0]
    print(price)
    print(imageURL)
    return price, imageURL

def getFoodInfo(name):
    params = urllib.parse.urlencode({
        # Request parameters
        'ingr': '{' + name + '}',
        'app_id': food_db_id,
        'app_key': food_db_key
    })
    try:
        conn = http.client.HTTPSConnection('api.edamam.com')
        conn.request("GET", "/api/food-database/parser?%s" % params)
        response = conn.getresponse()
        data = response.read()
        conn.close()
        return json.loads(data)
    except Exception as e:
        print("[Errno {0}] {1}".format(e.errno, e.strerror))
