from file_monitor import FileMonitor
from flask import Flask, jsonify
import threading
from flask_cors import CORS
import logging


monitor = FileMonitor()


app = Flask(__name__)
CORS(app)


def monitor_thread_func():
  monitor.run()


@app.route('/data')
def get_data():
  try:
    data = monitor.handler.get_latest_data()
    return jsonify(data)
  except Exception as e:
    return jsonify({"error": str(e)}), 500


def start_connection():
  """
  Starts the file monitor in a background thread and runs the Flask server.
  """
  t = threading.Thread(target=monitor_thread_func, daemon=True)
  t.start()
  logging.info("Starting Flask server...")
  app.run(host='0.0.0.0', port=5000)
