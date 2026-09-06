import unittest

from app import app


class PlatformDemoAppTests(unittest.TestCase):
    def setUp(self):
        self.client = app.test_client()

    def test_index(self):
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.get_json()["service"], "platform-demo")
        self.assertEqual(response.get_json()["status"], "ok")

    def test_healthz(self):
        response = self.client.get("/healthz")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.get_json(), {"status": "healthy"})

    def test_readyz(self):
        response = self.client.get("/readyz")
        self.assertEqual(response.status_code, 200)
        body = response.get_json()
        self.assertEqual(body["status"], "ready")
        self.assertIn("uptime_seconds", body)

    def test_metrics(self):
        self.client.get("/")
        response = self.client.get("/metrics")
        self.assertEqual(response.status_code, 200)
        payload = response.get_data(as_text=True)
        self.assertIn("platform_demo_http_requests_total", payload)
        self.assertIn("platform_demo_http_request_duration_seconds", payload)


if __name__ == "__main__":
    unittest.main()
