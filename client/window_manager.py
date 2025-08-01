from PyQt5.QtWidgets import (
    QMainWindow,
    QTextEdit,
    QVBoxLayout,
    QWidget,
)
from PyQt5.QtCore import pyqtSignal


class MainWindow(QMainWindow):

    add_entry_signal = pyqtSignal(str, str)

    def __init__(self):
        super().__init__()
        self._setup_ui()
        self.entries = []
        self.add_entry_signal.connect(self.add_entry)

    def _setup_ui(self):
        self.setWindowTitle("Chim Manager")
        self.setGeometry(300, 200, 700, 400)
        self.text_edit = QTextEdit()
        self.text_edit.setReadOnly(True)
        layout = QVBoxLayout()
        container = QWidget()
        container.setLayout(layout)
        layout.addWidget(self.text_edit)
        self.setCentralWidget(container)

    def add_entry(self, string1, string2):
        self.entries.append(f"{string1} - {string2}")
        self.text_edit.setPlainText("\n\n".join(self.entries))
