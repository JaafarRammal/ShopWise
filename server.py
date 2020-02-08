from flask import Flask, request, jsonify

app = Flask(__name__)
app.config["DEBUG"] = True

@app.route('/hello', methods=['GET'])
def hello_world():
    return "<html><body>Hello World!</body></html>"

if __name__ == '__main__':
    app.run(port=5000)