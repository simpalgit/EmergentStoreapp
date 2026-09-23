import json
import re
from http.server import HTTPServer, BaseHTTPRequestHandler

# ------------------------------------------------------------------------------
# EmergentStore Smart E-Commerce AI Chatbot Backend in Python
# ------------------------------------------------------------------------------

class ChatbotHandler(BaseHTTPRequestHandler):
    def _set_headers(self, status=200):
        self.send_response(status)
        self.send_header("Content-Type", "application/json")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Headers", "Content-Type")
        self.send_header("Access-Control-Allow-Methods", "POST, GET, OPTIONS")
        self.end_headers()

    def do_OPTIONS(self):
        self._set_headers(200)

    def do_GET(self):
        if self.path == "/health" or self.path == "/":
            self._set_headers(200)
            response = {
                "status": "online",
                "service": "EmergentStore Python AI Chatbot Server",
                "version": "1.0.0"
            }
            self.wfile.write(json.dumps(response).encode("utf-8"))
        else:
            self._set_headers(404)
            self.wfile.write(json.dumps({"error": "Not Found"}).encode("utf-8"))

    def do_POST(self):
        if self.path == "/api/chat":
            content_length = int(self.headers.get("Content-Length", 0))
            post_data = self.rfile.read(content_length)

            try:
                data = json.loads(post_data.decode("utf-8"))
                user_message = data.get("message", "").strip()
            except Exception:
                user_message = ""

            reply = self.generate_bot_response(user_message)
            self._set_headers(200)
            self.wfile.write(json.dumps(reply).encode("utf-8"))
        else:
            self._set_headers(404)
            self.wfile.write(json.dumps({"error": "Endpoint not found"}).encode("utf-8"))

    def generate_bot_response(self, text):
        msg = text.lower()

        # 1. Order Tracking / Delivery Status
        if any(w in msg for w in ["order", "track", "delivery", "status", "emg"]):
            return {
                "response": "🚚 Your latest order #EMG-89241 is Out for Delivery today by 6:00 PM with partner Rajesh Kumar!",
                "quick_replies": ["Track Order Live", "Change Address", "Contact Delivery Partner"],
                "recommendation": {
                    "title": "Order #EMG-89241",
                    "subtitle": "2 Items • Arriving Today",
                    "status": "Out for Delivery",
                    "action": "TRACK_ORDER"
                }
            }

        # 2. Sarees / Ethnic Wear / Fashion
        elif any(w in msg for w in ["saree", "ethnic", "kurti", "dress", "fashion", "clothes"]):
            return {
                "response": "✨ Here are our top trending Ethnic collections with flat 50% OFF today:",
                "quick_replies": ["View Sarees", "View Kurtis", "Apply Coupon FESTIVE50"],
                "recommendation": {
                    "title": "Silk Blend Banarasi Designer Saree",
                    "price": "₹1,299",
                    "originalPrice": "₹2,999",
                    "badge": "56% OFF",
                    "action": "VIEW_PRODUCT"
                }
            }

        # 3. Discounts / Offers / Coupons / Coins
        elif any(w in msg for w in ["coupon", "discount", "offer", "sale", "code", "coins", "cheap"]):
            return {
                "response": "🎁 Use code FESTIVE50 at checkout to get Flat 50% OFF + 200 Bonus EmergentCoins on your order!",
                "quick_replies": ["Copy FESTIVE50", "View All Coupons", "Scratch & Win"],
                "recommendation": {
                    "title": "FESTIVE50 - Flat 50% Discount",
                    "subtitle": "Valid on orders above ₹999",
                    "action": "COPY_COUPON"
                }
            }

        # 4. Electronics / Headphones / Watch
        elif any(w in msg for w in ["headphone", "audio", "watch", "electronics", "gadget"]):
            return {
                "response": "🎧 Check out the Wireless Noise Cancelling Bluetooth Headphones at 62% OFF today!",
                "quick_replies": ["Buy Headphones", "Smart Watches", "Audio Deals"],
                "recommendation": {
                    "title": "Wireless Noise Cancelling Headphones",
                    "price": "₹1,499",
                    "originalPrice": "₹3,999",
                    "badge": "Super Saver",
                    "action": "VIEW_PRODUCT"
                }
            }

        # 5. Return / Refund / Payment
        elif any(w in msg for w in ["return", "refund", "replace", "cancel", "payment", "upi"]):
            return {
                "response": "🛡️ EmergentStore offers 7-Day Easy Returns & Refunds directly credited to your Emergent Wallet or UPI account within 24 hours.",
                "quick_replies": ["Initiate Return", "Wallet Balance", "Talk to Agent"],
                "recommendation": {
                    "title": "7-Day Instant Return Policy",
                    "subtitle": "No questions asked doorstep pickup",
                    "action": "HELP_CENTER"
                }
            }

        # Default Greeting or General AI Response
        else:
            return {
                "response": f"Hello! I am Emergent AI Assistant 🤖. How can I help you regarding products, deals, order tracking, or discounts?",
                "quick_replies": ["Track Order", "Festive Sale 50% OFF", "Flash Deals 70% OFF", "Wallet & Coins"],
                "recommendation": None
            }

def run_server(port=5000):
    server_address = ("0.0.0.0", port)
    httpd = HTTPServer(server_address, ChatbotHandler)
    print(f"🚀 EmergentStore Python Chatbot Server running on http://0.0.0.0:{port}")
    httpd.serve_forever()

if __name__ == "__main__":
    run_server()
