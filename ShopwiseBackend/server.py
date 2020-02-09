from flask import Flask, jsonify

from ShopwiseBackend.blueprints.production_trace import production_trace
from ShopwiseBackend.blueprints.barcode import barcode
from ShopwiseBackend.blueprints.recipes import recipes
app = Flask(__name__)
app.config["DEBUG"] = True

app.register_blueprint(barcode, url_prefix='/api')
app.register_blueprint(production_trace, url_prefix='/api')
app.register_blueprint(recipes, url_prefix='/api')

tasks = [
    {
        'id': 1,
        'title': u'Buy groceries',
        'description': u'Milk, Cheese, Pizza, Fruit, Tylenol',
        'done': False
    },
    {
        'id': 2,
        'title': u'Learn Python',
        'description': u'Need to find a good Python tutorial on the web',
        'done': False
    }
]


@app.route('/tasks', methods=['GET'])
def get_tasks():
    return jsonify({'tasks': tasks})


@app.route("/")
def hello_world():
    return "hello world"


if __name__ == '__main__':
    app.run(port=5000)
