"""PyQt5 main window for ChimManager with logging display and QR code."""


import sys
import logging
import socket
from contextlib import contextmanager
from typing import Iterator
import qrcode
from PyQt5.QtWidgets import (
    QApplication,
    QMainWindow,
    QTextEdit,
    QVBoxLayout,
    QWidget,
    QLabel,
    QSplitter,
)
from PyQt5.QtCore import pyqtSignal, QObject, Qt
from PyQt5.QtGui import QPixmap, QImage


class QtLogHandler(logging.Handler, QObject):
  """Bridges Python logging to Qt signals."""
  log_signal = pyqtSignal(str)

  def __init__(self) -> None:
    logging.Handler.__init__(self)
    QObject.__init__(self)
    self.setFormatter(logging.Formatter("%(asctime)s - %(message)s"))

  def emit(self, record: logging.LogRecord) -> None:
    self.log_signal.emit(self.format(record))


@contextmanager
def udp_socket() -> Iterator[str]:
  """Context manager for UDP socket IP detection."""
  sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
  try:
    sock.connect(("10.255.255.255", 1))
    yield sock.getsockname()[0]
  except Exception:
    yield "127.0.0.1"
  finally:
    sock.close()


def get_local_ip() -> str:
  """Get the local IP address with fallback to localhost."""
  with udp_socket() as ip:
    return ip


class MainWindow(QMainWindow):
  """Main application window with log viewer and QR code."""
  MIN_QR_SIZE = 300

  def __init__(self) -> None:
    super().__init__()
    self._setup_ui()
    self._setup_logging()

  def _setup_ui(self) -> None:
    """Initialize window components and layout."""
    self.setWindowTitle("Chim Manager")
    self.setGeometry(300, 200, 700, 400)
    self.text_edit = QTextEdit()
    self.text_edit.setReadOnly(True)
    self.qr_label = self._create_qr_label()
    splitter = QSplitter(Qt.Orientation.Horizontal)
    splitter.addWidget(self.text_edit)
    splitter.addWidget(self.qr_label)
    splitter.setSizes([250, 150])
    layout = QVBoxLayout()
    container = QWidget()
    container.setLayout(layout)
    layout.addWidget(splitter)
    self.setCentralWidget(container)

  def _create_qr_label(self) -> QLabel:
    """Generate and configure QR code label with proper typing."""
    try:
      # Explicitly type the QR code image
      qr_code = qrcode.make(f"http://{get_local_ip()}:5000/data")
      qr_img = qr_code.convert("RGBA")
      # Convert to QImage
      qimage = QImage(
          qr_img.tobytes("raw", "RGBA"),
          qr_img.size[0],
          qr_img.size[1],
          QImage.Format_RGBA8888
      )
      # Create and scale pixmap
      pixmap = QPixmap.fromImage(qimage)
      if qr_img.size[0] < self.MIN_QR_SIZE:
        pixmap = pixmap.scaled(
            self.MIN_QR_SIZE,
            self.MIN_QR_SIZE,
            Qt.KeepAspectRatio
        )
      return QLabel(pixmap=pixmap, alignment=Qt.AlignCenter)
    except Exception as e:
      logging.error("QR generation failed: %s", e)
      return QLabel("QR Code Unavailable", alignment=Qt.AlignCenter)

  def _setup_logging(self) -> None:
    """Configure logging for Qt display."""
    self.log_handler = QtLogHandler()
    qt_monitor_logger = logging.getLogger("qt_monitor")
    qt_monitor_logger.addHandler(self.log_handler)
    qt_monitor_logger.setLevel(logging.INFO)
    qt_monitor_logger.propagate = False
    self.log_handler.log_signal.connect(self.append_log)

  def append_log(self, message: str) -> None:
    """Append message to log display."""
    self.text_edit.append(message)


def run_window() -> None:
  """Initialize and run the application window."""
  app = QApplication(sys.argv)
  window = MainWindow()
  window.show()
  exit_code = app.exec_()
  # Cleanup
  logging.getLogger("qt_monitor").removeHandler(window.log_handler)
  sys.exit(exit_code)
