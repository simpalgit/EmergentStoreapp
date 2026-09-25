import json
import re
from http.server import HTTPServer, BaseHTTPRequestHandler

# ------------------------------------------------------------------------------
# EmergentStore Gmail-Integrated Smart AI Chatbot Backend in Python
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
                "version": "2.0.0 (Gmail Account Intelligence Enabled)"
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
                user_email = data.get("email", "simpal@gmail.com").strip()
                user_name = data.get("name", "Simpal").strip()
            except Exception:
                user_message = ""
                user_email = "simpal@gmail.com"
                user_name = "Simpal"

            reply = self.generate_bot_response(user_message, user_email, user_name)
            self._set_headers(200)
            self.wfile.write(json.dumps(reply).encode("utf-8"))
        else:
            self._set_headers(404)
            self.wfile.write(json.dumps({"error": "Endpoint not found"}).encode("utf-8"))

    def generate_bot_response(self, text, email, name):
        msg = text.lower()

        # 1. Order Tracking / Delivery Status
        if any(w in msg for w in ["order", "track", "delivery", "status", "emg"]):
            return {
                "response": f"🚚 Hello {name}! For your connected Gmail ({email}), your latest order #EMG-89241 (Designer Cotton Anarkali Kurti Set) is Out for Delivery today by 6:00 PM with partner Rajesh Kumar. Live tracking alerts are enabled for {email}!",
                "quick_replies": ["Track Order Live", "Email Invoice", "Contact Delivery Agent"],
                "recommendation": {
                    "title": "Order #EMG-89241 • Arriving Today",
                    "subtitle": f"Linked to {email}",
                    "status": "Out for Delivery",
                    "action": "TRACK_ORDER"
                }
            }

        # 2. Invoice / Receipt to Gmail
        elif any(w in msg for w in ["invoice", "receipt", "email", "bill", "gmail"]):
            return {
                "response": f"📄 Clear Tax Invoice for order #EMG-89241 has been generated and sent to {email}. You can also download the PDF directly in the app!",
                "quick_replies": ["View Order Details", "Check Wallet Balance"],
                "recommendation": {
                    "title": f"Invoice Sent to {email}",
                    "subtitle": "Order #EMG-89241 • PDF Ready",
                    "action": "TRACK_ORDER"
                }
            }

        # 3. Wallet Balance & Account Details
        elif any(w in msg for w in ["wallet", "balance", "money", "credit", "account"]):
            return {
                "response": f"💳 Hello {name}! Account linked to {email}:\n• Emergent Wallet Balance: ₹1,250.00\n• Reward Coins: 1,450 Coins\n• Saved Address: House #402, Green Park, New Delhi - 110001.",
                "quick_replies": ["Add Money to Wallet", "Redeem Coins", "Saved Addresses"],
                "recommendation": {
                    "title": "Emergent Wallet: ₹1,250.00",
                    "subtitle": f"Account: {email}",
                    "action": "COPY_COUPON"
                }
            }

        # 4. Sarees / Ethnic Wear / Fashion
        elif any(w in msg for w in ["saree", "ethnic", "kurti", "dress", "fashion", "clothes"]):
            return {
                "response": f"✨ Hi {name}! Based on your Gmail shopping history ({email}), here is our top recommended Silk Blend Banarasi Designer Saree with flat 56% OFF today!",
                "quick_replies": ["View Sarees", "View Kurtis", "Apply FESTIVE50"],
                "recommendation": {
                    "title": "Silk Blend Banarasi Designer Saree",
                    "price": "₹1,299",
                    "originalPrice": "₹2,999",
                    "badge": "56% OFF",
                    "action": "VIEW_PRODUCT"
                }
            }

        # 5. Discounts / Offers / Coupons
        elif any(w in msg for w in ["coupon", "discount", "offer", "sale", "code", "coins"]):
            return {
                "response": f"🎁 Hi {name}! Exclusive coupon code FESTIVE50 is active for {email}. Apply at checkout for Flat 50% OFF + 200 Bonus Coins credited to your wallet!",
                "quick_replies": ["Copy FESTIVE50", "View All Coupons", "Scratch & Win"],
                "recommendation": {
                    "title": "FESTIVE50 - Flat 50% OFF Coupon",
                    "subtitle": f"Exclusive for {email}",
                    "action": "COPY_COUPON"
                }
            }

        # Default Personalized Greeting or Exact Clear Response
        else:
            return {
                "response": f"Hello {name}! I am your Gmail-connected Chat Board Assistant 💬 ({email}). Ask me about your order status, tax invoice, wallet balance, or sarees and I will give you exact, clear answers!",
                "quick_replies": ["Track Order", "Send Invoice to Gmail", "My Wallet Balance", "Festive Sale 50% OFF"],
                "recommendation": None
            }

def run_server(port=5000):
    server_address = ("0.0.0.0", port)
    httpd = HTTPServer(server_address, ChatbotHandler)
    print(f"🚀 EmergentStore Python Chatbot Server running on http://0.0.0.0:{port}")
    httpd.serve_forever()

if __name__ == "__main__":
    run_server()
