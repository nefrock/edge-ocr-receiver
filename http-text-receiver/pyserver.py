from http.server import HTTPServer
from http.server import BaseHTTPRequestHandler


class CustomHTTPRequestHandler(BaseHTTPRequestHandler):

    def do_POST(self):
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.end_headers()
        print(self.rfile.read(int(self.headers["content-length"])).decode("utf-8"))
        html_context = "done"
        self.wfile.write(html_context.encode())


server_address = ("0.0.0.0", 8080)
httpd = HTTPServer(server_address, CustomHTTPRequestHandler)
httpd.serve_forever()
