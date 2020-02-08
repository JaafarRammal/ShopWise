from flask import Flask, jsonify
from blueprints.barcode import barcode

app = Flask(__name__)
app.config["DEBUG"] = True

app.register_blueprint(barcode)

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
    app.run()
