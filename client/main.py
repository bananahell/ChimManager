from connection_maker import start_connection
from window_manager import run_window
import threading
import logging


if __name__ == '__main__':
  logging.basicConfig(level=logging.INFO)

  # Start the Flask server and file monitor in a thread
  flask_thread = threading.Thread(target=start_connection, daemon=True)
  flask_thread.start()

  # Start the GUI in the main thread (recommended for PyQt)
  run_window()
