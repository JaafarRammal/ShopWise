from flask import Flask
from blueprints.barcode import barcode
from blueprints.recipes import recipes
app = Flask(__name__)
app.config["DEBUG"] = True

app.register_blueprint(barcode)
app.register_blueprint(recipes)

if __name__ == '__main__':
    app.run(port=5000)