import sys
from window_manager import MainWindow
from file_monitor import FileMonitor
import threading
from PyQt5.QtWidgets import QApplication


def main():
    app = QApplication(sys.argv)
    window = MainWindow()
    fileMonitor = FileMonitor(window)
    threading.Thread(target=fileMonitor.run, daemon=True).start()
    window.show()
    exit_code = app.exec_()
    sys.exit(exit_code)


if __name__ == '__main__':
    main()
