import difflib
import json
from flask import Blueprint
import http.client, urllib.request, urllib.parse, urllib.error

barcode = Blueprint('barcode', __name__)

food_db_key = "ad08b45030aa9122d39cbb6efb154f87"
food_db_id = "78938bf0"

eanToken = 'cee7b3d1236f7076c16d0f9a02d4e5'

# headers = {
#   'Content-Type': 'application/json',
#   'Accept': 'application/json'
# }

# test = """[{"ean":"7622210740489","name":"Belvita Milk and Cereal Biscuits 12 Pack 540G","categoryId":"0","categoryName":"Unknown"}] """

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

@barcode.route('/ean/<ean>')
def get_product(ean):
    product = json.loads(getInfo(ean))
    # product = json.loads(test)
    name = product[0].get("name")
    price, imageURL = getPrice(name.lower())
    foodData = getFoodInfo(name.lower())
    nutrients, allAlts = getNutrients(foodData, name)
    lowCalAlt, lowFatAlt, lowCarbAlt = getAlts(allAlts)

    result = getResultJSON(ean, name, price, imageURL, nutrients, lowCalAlt, lowFatAlt, lowCarbAlt)
    return json.dumps(result)


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
    print(foodData)
    possibleMatches = foodData.get('hints')
    print(possibleMatches)
    bestMatchLabel = difflib.get_close_matches(name.lower(), map(getLabel, possibleMatches), n=1, cutoff=0.2)[0]
    print(bestMatchLabel)
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
        print("Ean number not recognised: " + str(ean))

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
        print(data)
        # data = '{"code":"OK","total":13226,"offset":5,"items":[{"ean":"0721864863944","title":"Twix Biscuit Fingers (9x23g)","description":"","upc":"721864863944","asin":"B00MTV2NLC","brand":"Twix","model":"","color":"","size":"","dimension":"2 X 7.9 X 7.9 inches","weight":"","lowest_recorded_price":3.59,"highest_recorded_price":6.49,"images":[],"offers":[],"elid":"271897304152"},{"ean":"0721865327520","title":"Twix Biscuit Fingers 16x23g - Pack Of 2","description":"","upc":"721865327520","asin":"B00XJN8Q0Q","brand":"Twix","model":"","color":"","size":"","dimension":"2 X 7.9 X 7.9 inches","weight":"","lowest_recorded_price":19.99,"highest_recorded_price":24.85,"images":[],"offers":[],"elid":"143326382139"},{"ean":"0721865350559","title":"Twix Biscuit Fingers (7x58g) - Pack Of 6","description":"","upc":"721865350559","asin":"B00XP89Z0U","brand":"Twix","model":"","color":"","size":"","dimension":"2 X 7.9 X 7.9 inches","weight":"","lowest_recorded_price":39.49,"highest_recorded_price":63.49,"images":[],"offers":[],"elid":"283039711311"},{"ean":"0721865352010","title":"Twix Biscuit Fingers (16x23g) - Pack Of 6","description":"","upc":"721865352010","asin":"B00XP86TD6","brand":"Twix","model":"","color":"","size":"","dimension":"2 X 7.9 X 7.9 inches","weight":"","lowest_recorded_price":40.99,"highest_recorded_price":40.99,"images":[],"offers":[],"elid":"273341004521"},{"ean":"0721865354892","title":"Twix Biscuit Fingers 9x23g - Pack Of 6","description":"","upc":"721865354892","asin":"B00XP7YPEM","brand":"Twix","model":"","color":"","size":"","dimension":"2 X 7.9 X 7.9 inches","weight":"","lowest_recorded_price":25.49,"highest_recorded_price":43.23,"images":[],"offers":[],"elid":"143326384620"}]}'
        conn.close()
        res = json.loads(data)['items'][0]
        price = (res['lowest_recorded_price'] + res['highest_recorded_price']) / 2
        print(price)
        imageURL = res['images']
        if imageURL != []:
            imageURL = imageURL[0]
        print("here")
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
