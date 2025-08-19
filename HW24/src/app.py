from flask import Flask, jsonify
import os, socket, random, string

app = Flask(__name__)

def randstr(n=12):
    return ''.join(random.choices(string.ascii_letters + string.digits, k=n))

@app.route("/")
def index():
    pod = os.getenv("POD_NAME", socket.gethostname())
    return jsonify(pod=pod, hostname=socket.gethostname(), random=randstr())

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
