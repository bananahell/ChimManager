from watchdog.observers import Observer
from watchdog.events import PatternMatchingEventHandler
from lupa import LuaRuntime
import time


class Handler(PatternMatchingEventHandler):
    def __init__(self):
        super().__init__(patterns=["ChimManager.lua"],
                         ignore_directories=True, case_sensitive=False)
        self._last_event_time = 0
        self._string1 = ""
        self._string2 = ""

    def on_modified(self, event):
        now = time.time()
        if now - self._last_event_time < 0.5:
            return
        self._last_event_time = now
        time.sleep(0.2)
        self.read_file(str(event.src_path))

    def read_file(self, filepath):
        with open(filepath, 'r') as f:
            lua_code = f.read()
        lua = LuaRuntime(unpack_returned_tuples=True)
        lua.execute(lua_code)
        data = lua.eval('ChimManagerSavedVars')
        ##########################################################################
        # TODO functionality placeholder
        self._string1 = "Top-level keys: " + \
            ' '.join(str(k) for k in data.keys())
        # Example: print all character names for @BananaHell
        chars = data['Default']['@BananaHell']
        self._string2 = "Characters: " + ' '.join(str(k) for k in chars.keys())
        print(self._string1)
        print(self._string2)
        ##########################################################################

    def get_latest_data(self):
        return {
            "string1": self._string1,
            "string2": self._string2
        }


class FileMonitor:
    def __init__(self):
        self.path = "."
        self.handler = Handler()
        self.observer = Observer()
        self.observer.schedule(self.handler, path=self.path, recursive=True)
        self.observer.start()

    def run(self):
        try:
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            self.observer.stop()
        self.observer.join()
