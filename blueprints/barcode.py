import difflib
import json
from flask import Blueprint
import http.client, urllib.request, urllib.parse, urllib.error

barcode = Blueprint('barcode', __name__)

food_db_key = "ad08b45030aa9122d39cbb6efb154f87"
food_db_id = "78938bf0"

eanToken = 'cee7b3d1236f7076c16d0f9a02d4e5'

def getResultJSON(ean, name, price, imageURL, nutrients, lowCalAlt, lowFatAlt, lowCarbAlt):
        return {
            "ean": ean,
            "name": name,
            "price": price,
            "imageURL": imageURL,
            "nutrients": nutrients,
            "lowCalAlt": lowCalAlt,
            "lowFatAlt": lowFatAlt,
            "lowCarbAlt": lowCarbAlt
        }

@barcode.route('/ean/<ean>', methods=['GET'])
def get_product(ean):
    product = json.loads(getInfo(ean))
    name = product[0].get("name")
    price, imageURL = getPrice(name.lower())
    foodData = getFoodInfo(name.lower())
    nutrients, allAlts = getNutrients(foodData, name)
    lowCalAlt, lowFatAlt, lowCarbAlt = getAlts(allAlts)

    result = getResultJSON(ean, name, price, imageURL, nutrients, lowCalAlt, lowFatAlt, lowCarbAlt)
    return json.dumps(result)

def getResultJSON(ean, name, price, imageURL, nutrients, lowCalAlt, lowFatAlt, lowCarbAlt):
        return {"ean": ean,
        "name": name,
        "price": price,
        "imageURL": imageURL,
        "nutrients": nutrients,
        "lowCalAlt": lowCalAlt,
        "lowFatAlt": lowFatAlt,
        "lowCarbAlt": lowCarbAlt}

def getAlts(allAlts):
    (lowestCal, labelCal) = (getCals(allAlts[0]), getLabel(allAlts[0]))
    (lowestFat, labelFat) = (getFat(allAlts[0]), getLabel(allAlts[0]))
    (lowestCarbs, labelCarbs) = (getCarbs(allAlts[0]), getLabel(allAlts[0]))
    for alt in allAlts[1:]:
        if getCals(alt) != -1 and getCals(alt) < lowestCal:
            lowestCal = getCals(alt)
            labelCal = getLabel(alt)
        if getFat(alt) != -1 and getFat(alt) < lowestFat:
            lowestFat = getFat(alt)
            labelFat= getLabel(alt)
        if getCarbs(alt) != -1 and getCarbs(alt) < lowestCarbs:
            lowestCarbs = getCarbs(alt)
            labelCarbs = getLabel(alt)

    return (lowestCal, labelCal), (lowestFat, labelFat), (lowestCarbs, labelCarbs)


def getCals(food):
    try:
        res = food['food']['nutrients']['ENERC_KCAL']
        return res
    except KeyError as e:
        return -1


def getFat(food):
    try:
        res = food['food']['nutrients']['FAT']
        return res
    except KeyError as e:
        return -1

def getCarbs(food):
    try:
        res = food['food']['nutrients']['CHOCDF']
        return res
    except KeyError as e:
        return -1

def getNutrients(foodData, name):
    possibleMatches = foodData.get('hints')
    bestMatchLabel = difflib.get_close_matches(name.lower(), map(getLabel, possibleMatches), n=1, cutoff=0.2)[0]
    for m in possibleMatches:
        if getLabel(m) == bestMatchLabel:
            bestMatch = m
            possibleMatches.remove(m)
            return bestMatch['food']['nutrients'], possibleMatches

def getLabel(x):
    return x['food']['label']

def getInfo(ean):
    req = 'token=' + eanToken + '&op=barcode-lookup&format=json&ean=' + ean
    try:
        conn = http.client.HTTPSConnection('api.ean-search.org')
        conn.request("GET", "/api?%s" % req)
        response = conn.getresponse()
        data = response.read()
        conn.close()
        return data
    except Exception as e:
        print("EAN not recognised: " + str(ean))

def getPrice(name):
    headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
    }
    params = {'s': name}
    nameTrim = urllib.parse.urlencode(params, quote_via=urllib.parse.quote)

    try:
        conn = http.client.HTTPSConnection('api.upcitemdb.com')
        conn.request("GET", "/prod/trial/search?s=" + nameTrim + "&match_mode=0&type=product", headers=headers)
        response = conn.getresponse()
        data = response.read()
        conn.close()
        res = json.loads(data)['items'][0]
        price = (res['lowest_recorded_price'] + res['highest_recorded_price']) / 2
        imageURL = res['images']
        if imageURL != []:
            imageURL = imageURL[0]
        else:
            imageURL = "https://digitalcontent.api.tesco.com/v2/media/ghs/70114a23-d3ca-47b1-8eba-2a6d52649a99/snapshotimagehandler_1648160855.jpeg?h=225&w=225"
        return price, imageURL
    except Exception as e:
        print("Price data not found for product: " + name)

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
        print("Could not find nutritional information for " + name)
