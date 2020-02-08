import json

from flask import Blueprint, Response, request
import http.client, urllib.request, urllib.parse, urllib.error, base64

barcode = Blueprint('barcode', __name__)

tesco_key = "06948dd2153541ee8bb8a74ccb67061b"

headers = {
    # Request headers
    'Ocp-Apim-Subscription-Key': '{'+tesco_key+'}',
}

class Product:
    def __init__(self, gtin, name, price, trace):
        self.gtin = gtin
        self.name = name
        self.price = price
        self.trace = trace

@barcode.route('/gtin/<id>')
def get_product(id):

    ## MAKE API CALL TO TESCO

    print("Hello")
    product = tescoProduct(id)

    priceInfo = tescoGrocery(product)

def tescoProduct(gtin):
    params = urllib.parse.urlencode({
        # Request parameters
        'gtin': '{' + gtin + '}'
    })

    try:
        conn = http.client.HTTPSConnection('dev.tescolabs.com')
        conn.request("GET", "/product/?%s" % params, "{body}", headers)
        response = conn.getresponse()
        data = response.read()
        print(data)
        conn.close()
        return json.loads(data)
    except Exception as e:
        print("[Errno {0}] {1}".format(e.errno, e.strerror))

def tescoGrocery(product):
    return