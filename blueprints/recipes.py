import http.client
import json
import urllib.parse

from flask import Blueprint

recipes = Blueprint('recipes', __name__)

recipe_db_id = "b287e1d1"
recipe_db_key = "466410d065ec83423cc3dab6877c83bf"

MAX_INGREDIENT_NUM = 8

@recipes.route('/recipes/<string:ingrs>', methods=['GET'])
def getRecipes(ingrs):
    rawRecipe = getRawRecipe(ingrs)
    recipes = []
    for i in range(min(5, rawRecipe['count'])):
        rec = rawRecipe['hits'][i]['recipe']
        res = {
            'label': rec['label'],
            'healthLabels': rec['healthLabels'],
            'imageURL': rec['image'],
            'ingredients': rec['ingredientLines'],
            'urlSource': rec['url']
        }
        recipes.append(res)
    return json.dumps(recipes)




def getRawRecipe(ingrs):
    params = urllib.parse.urlencode({
        # Request parameters
        'q': '{' + ingrs + '}',
        'ingrs': MAX_INGREDIENT_NUM,
        'app_id': recipe_db_id,
        'app_key': recipe_db_key,
        'to': 5
    })
    try:
        conn = http.client.HTTPSConnection('api.edamam.com')
        conn.request("GET", "/search?%s" % params)
        response = conn.getresponse()
        data = response.read()
        conn.close()
        return json.loads(data)
    except Exception as e:
        print("Could not find any recipes for the given ingredients: " + ingrs)