import sys
from window_manager import MainWindow
from file_monitor import FileMonitor
import threading
from PyQt5.QtWidgets import QApplication
from api_server import ApiServer


def main() -> None:
    app: QApplication = QApplication(sys.argv)
    window: MainWindow = MainWindow()
    file_monitor: FileMonitor = FileMonitor(window)
    api_server: ApiServer = ApiServer(file_monitor.handler)
    threading.Thread(target=file_monitor.run, daemon=True).start()
    threading.Thread(target=api_server.run, daemon=True).start()
    window.show()
    exit_code: int = app.exec_()
    sys.exit(exit_code)


if __name__ == '__main__':
    main()
