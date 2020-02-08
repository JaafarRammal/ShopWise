import json

from flask import Blueprint, Response, request
import http.client, urllib.request, urllib.parse, urllib.error, base64

barcode = Blueprint('barcode', __name__)

food_db_key = "ad08b45030aa9122d39cbb6efb154f87"
food_db_id = "78938bf0"

# headers = {
#     # Request headers
#     'Ocp-Apim-Subscription-Key': '{' + food_db_key + '}',
# }

class Product:
    def __init__(self, gtin, name, price, trace):
        self.gtin = gtin
        self.name = name
        self.price = price
        self.trace = trace

@barcode.route('/upc/<id>')
def get_product(id):

    product = getInfo(id)
    return product

def getInfo(upc):
    params = urllib.parse.urlencode({
        # Request parameters
        'upc': '{' + upc + '}',
        'app_id': food_db_id,
        'app_key': food_db_key
    })

    try:
        conn = http.client.HTTPSConnection('api.edamam.com')
        conn.request("GET", "/api/food-database/parser?%s" % params)
        response = conn.getresponse()
        data = response.read()
        print(data)
        conn.close()
        return data
    except Exception as e:
        print("[Errno {0}] {1}".format(e.errno, e.strerror))
