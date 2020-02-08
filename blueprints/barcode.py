import json
from flask import Blueprint, Response, request
import requests
import http.client, urllib.request, urllib.parse, urllib.error, base64

barcode = Blueprint('barcode', __name__)

# food_db_key = "ad08b45030aa9122d39cbb6efb154f87"
# food_db_id = "78938bf0"

eanToken = 'cee7b3d1236f7076c16d0f9a02d4e5'

# headers = {
#   'Content-Type': 'application/json',
#   'Accept': 'application/json'
# }

test = """[{"ean":"7622210740489","name":"Belvita Milk and Cereal Biscuits 12 Pack 540G","categoryId":"0","categoryName":"Unknown"}] """

class Product:
    def __init__(self, upc, name, price, trace):
        self.upc = upc
        self.name = name

@barcode.route('/ean/<id>')
def get_product(id):

    # product = getInfo(id)
    product = test
    obj = json.loads(product)
    name = obj[0].get("name")
    # print(obj['name'])
    price, imageURL = getPrice(name)

    # parsed = Product(upc, "")

    return product

def getInfo(ean):
    # params = urllib.parse.urlencode({
    #     # Request parameters
    #     'upc': '{' + upc + '}',
    #     'app_id': food_db_id,
    #     'app_key': food_db_key
    # })
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