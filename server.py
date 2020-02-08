from flask import Flask
from blueprints.barcode import barcode

app = Flask(__name__)
app.config["DEBUG"] = True

app.register_blueprint(barcode)

@app.route("/")
def hello_world():
    return "hello world"

if __name__ == '__main__':
    app.run()