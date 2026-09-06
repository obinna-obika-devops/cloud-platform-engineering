import os
import time
from flask import Flask, Response, jsonify, request
from prometheus_client import CONTENT_TYPE_LATEST, Counter, Histogram, generate_latest

app = Flask(__name__)
START = time.time()

REQUEST_COUNT = Counter(
    "platform_demo_http_requests_total",
    "Total HTTP requests handled by the service.",
    ["method", "path", "status"],
)
REQUEST_LATENCY = Histogram(
    "platform_demo_http_request_duration_seconds",
    "HTTP request latency in seconds.",
    ["method", "path"],
)


@app.before_request
def start_request_timer():
    request._platform_start_time = time.perf_counter()


@app.after_request
def record_request_metrics(response):
    if request.path != "/metrics":
        path = request.url_rule.rule if request.url_rule else "unmatched"
        elapsed = time.perf_counter() - getattr(request, "_platform_start_time", time.perf_counter())
        REQUEST_LATENCY.labels(request.method, path).observe(elapsed)
        REQUEST_COUNT.labels(request.method, path, str(response.status_code)).inc()
    return response


@app.get("/")
def index():
    return jsonify(
        service="platform-demo",
        status="ok",
        version=os.getenv("APP_VERSION", "1.0.0"),
    )


@app.get("/healthz")
def healthz():
    return jsonify(status="healthy")


@app.get("/readyz")
def readyz():
    return jsonify(status="ready", uptime_seconds=round(time.time() - START, 2))


@app.get("/metrics")
def metrics():
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
