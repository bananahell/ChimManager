import sys
from PyQt5.QtWidgets import QApplication, QMainWindow


class MainWindow(QMainWindow):
  def __init__(self):
    super().__init__()
    self.setWindowTitle("My cool first GUI")
    self.setGeometry(300, 200, 700, 400)


def run_window():
  app = QApplication(sys.argv)
  window = MainWindow()
  window.show()
  sys.exit(app.exec_())
