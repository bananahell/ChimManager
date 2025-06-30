import logging
import threading
from flask import Flask, jsonify, Response
from flask_cors import CORS
from file_monitor import FileMonitor
from typing import Union, Tuple


# Module-level logger configuration
logger = logging.getLogger(__name__)


def configure_flask_logging() -> None:
  """Configure Flask/Werkzeug logging to reduce noise."""
  logging.getLogger('werkzeug').setLevel(logging.WARNING)


def create_app(monitor: FileMonitor) -> Flask:
  """Factory function to create and configure the Flask application.
  Args:
      monitor: FileMonitor instance to use for data access
  Returns:
      Flask: Configured Flask application instance
  """
  app = Flask(__name__)
  CORS(app)
  configure_flask_logging()

  @app.route('/data', methods=['GET'])
  def get_data() -> Union[Response, Tuple[Response, int]]:
    """Endpoint to retrieve the latest monitoring data.
    Returns:
        tuple: (JSON response, HTTP status code)
    """
    try:
      return jsonify(monitor.handler.get_latest_data()), 200
    except Exception as error:
      logger.error("Data retrieval failed: %s", error, exc_info=True)
      return jsonify({"error": str(error)}), 500

  return app


def run_monitor(monitor: FileMonitor) -> None:
  """Run the file monitor in the current thread.
  Args:
      monitor: FileMonitor instance to run
  """
  logger.info("Starting file monitor service")
  monitor.run()


def start_connection() -> None:
  """Start the application services.
  Initializes and runs:
  - File monitoring in background thread
  - Flask REST API in main thread

  Note:
      This function does not return as it runs the Flask server indefinitely.
  """
  monitor = FileMonitor()
  app = create_app(monitor)
  threading.Thread(
      target=run_monitor,
      args=(monitor,),
      daemon=True,
      name="FileMonitorService"
  ).start()
  logger.info("Starting Flask API server on port 5000")
  app.run(host='0.0.0.0', port=5000)
