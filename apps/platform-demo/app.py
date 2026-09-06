from flask import Flask, jsonify
import os, time
app = Flask(__name__)
START = time.time()

@app.get("/")
def index():
    return jsonify(service="platform-demo", status="ok", version=os.getenv("APP_VERSION", "1.0.0"))

@app.get("/healthz")
def healthz():
    return jsonify(status="healthy")

@app.get("/readyz")
def readyz():
    return jsonify(status="ready", uptime_seconds=round(time.time() - START, 2))

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
