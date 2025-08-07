from flask import Flask, jsonify, Response
from file_monitor import Handler


class ApiServer:

    def __init__(self, handler) -> None:
        self.app: Flask = Flask(__name__)
        self.handler: Handler = handler
        self.app.add_url_rule(
            "/characters", "get_characters", self.get_characters)

    def get_characters(self) -> Response:
        return jsonify(self.handler.get_latest_data())

    def run(self) -> None:
        self.app.run(host="0.0.0.0", port=5000)
