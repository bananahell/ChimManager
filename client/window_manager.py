from PyQt5.QtWidgets import (
    QMainWindow,
    QTextEdit,
    QVBoxLayout,
    QWidget,
)
from PyQt5.QtCore import pyqtSignal
import socket
from PIL import Image
import qrcode
from PyQt5.QtWidgets import (
    QMainWindow,
    QTextEdit,
    QVBoxLayout,
    QWidget,
    QLabel,
    QSplitter,
)
from PyQt5.QtCore import pyqtSignal, Qt
from PyQt5.QtGui import QPixmap, QImage


class MainWindow(QMainWindow):

    MIN_QR_SIZE: int = 300
    add_entry_signal: pyqtSignal = pyqtSignal(str, str)

    def __init__(self) -> None:
        super().__init__()
        self._setup_ui()
        self.entries: list[str] = []
        self.add_entry_signal.connect(self.add_entry)

    def _setup_ui(self) -> None:
        self.setWindowTitle("Chim Manager")
        self.setGeometry(300, 200, 700, 400)
        self.text_edit: QTextEdit = QTextEdit()
        self.text_edit.setReadOnly(True)
        self.qr_label = self._create_qr_label()
        splitter: QSplitter = QSplitter(Qt.Orientation.Horizontal)
        splitter.addWidget(self.text_edit)
        splitter.addWidget(self.qr_label)
        splitter.setSizes([250, 150])
        layout: QVBoxLayout = QVBoxLayout()
        container: QWidget = QWidget()
        container.setLayout(layout)
        layout.addWidget(splitter)
        self.setCentralWidget(container)

    def _create_qr_label(self) -> QLabel:
        try:
            qr_code = qrcode.make(MainWindow.get_local_ip())
            qr_img: Image.Image = qr_code.convert("RGBA")
            qimage: QImage = QImage(
                qr_img.tobytes("raw", "RGBA"),
                qr_img.size[0],
                qr_img.size[1],
                QImage.Format_RGBA8888
            )
            pixmap: QPixmap = QPixmap.fromImage(qimage)
            if qr_img.size[0] < self.MIN_QR_SIZE:
                pixmap = pixmap.scaled(
                    self.MIN_QR_SIZE,
                    self.MIN_QR_SIZE,
                    Qt.KeepAspectRatio
                )
            return QLabel(pixmap=pixmap, alignment=Qt.AlignCenter)
        except Exception as exception:
            print(f"QR Code generation failed: {exception}")
            return QLabel("QR Code Unavailable", alignment=Qt.AlignCenter)

    def add_entry(self, string1: str, string2: str) -> None:
        self.entries.append(f"{string1} - {string2}")
        self.text_edit.setPlainText("\n\n".join(self.entries))

    @staticmethod
    def get_local_ip() -> str:
        try:
            s: socket.socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            s.connect(("8.8.8.8", 80))
            ip: str = s.getsockname()[0]
            s.close()
            return ip
        except Exception:
            return "127.0.0.1"
