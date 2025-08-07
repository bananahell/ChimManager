from watchdog.observers import Observer
from watchdog.events import PatternMatchingEventHandler
from lupa import LuaRuntime
import time
from typing import Any
from window_manager import MainWindow


class Handler(PatternMatchingEventHandler):

    def __init__(self, window: MainWindow) -> None:
        super().__init__(patterns=["ChimManager.lua"],
                         ignore_directories=True, case_sensitive=False)
        self._last_event_time: float = 0
        self._string1: str = ""
        self._string2: str = ""
        self.window: MainWindow = window

    def on_modified(self, event: Any) -> None:
        now: float = time.time()
        if now - self._last_event_time < 0.5:
            return
        self._last_event_time = now
        time.sleep(0.2)
        self.read_file(str(event.src_path))

    def read_file(self, filepath: str) -> None:
        with open(filepath, 'r') as f:
            lua_code: str = f.read()
        lua: LuaRuntime = LuaRuntime(unpack_returned_tuples=True)
        lua.execute(lua_code)
        data: Any = lua.eval('ChimManagerSavedVars')
        ########################################################################
        # TODO functionality placeholder
        self._string1 = "Top-level keys: " + \
            ' '.join(str(k) for k in data.keys())
        # Example: print all character names for @BananaHell
        chars: Any = data['Default']['@BananaHell']
        self._string2 = "Characters: " + ' '.join(str(k) for k in chars.keys())
        print(self._string1)
        print(self._string2)
        ########################################################################
        if self.window:
            self.window.add_entry_signal.emit(self._string1, self._string2)

    def get_latest_data(self) -> dict[str, str]:
        return {
            "string1": self._string1,
            "string2": self._string2
        }


class FileMonitor:

    def __init__(self, window: MainWindow) -> None:
        self.path: str = "."
        self.handler: Handler = Handler(window)
        self.observer = Observer()
        self.observer.schedule(self.handler, path=self.path, recursive=True)
        self.observer.start()

    def run(self) -> None:
        try:
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            self.observer.stop()
        self.observer.join()
