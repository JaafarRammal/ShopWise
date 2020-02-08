from flask import Flask, request, jsonify

app = Flask(__name__)
app.config["DEBUG"] = True

@app.route('/hello', methods=['GET'])
def hello_world():
    return 'Hey, we have Flask in a Docker container!'


if __name__ == '__main__':
    app.run(port=5000)