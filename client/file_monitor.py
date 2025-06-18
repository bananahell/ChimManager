import time
import logging
from watchdog.observers import Observer
from watchdog.events import PatternMatchingEventHandler
from lupa import LuaRuntime
from typing import Any
from watchdog.events import FileSystemEvent


logging.basicConfig(level=logging.INFO)


class Handler(PatternMatchingEventHandler):
  """Watches for changes to ChimManager.lua and processes updates."""

  def __init__(self):
    super().__init__(patterns=["ChimManager.lua"],
                     ignore_directories=True, case_sensitive=False)
    self._last_event_time = 0
    self._string1 = ""
    self._string2 = ""

  def on_modified(self, event: FileSystemEvent) -> None:
    now = time.time()
    if now - self._last_event_time < 0.5:
      return
    self._last_event_time = now
    time.sleep(0.2)
    logging.info(f"Watchdog received modified event - {event.src_path}")
    self.read_file(str(event.src_path))

  def read_file(self, filepath: str) -> None:
    try:
      with open(filepath, 'r') as f:
        lua_code = f.read()
      lua = LuaRuntime(unpack_returned_tuples=True)
      lua_code = '\n'.join(line for line in lua_code.splitlines()
                           if not line.strip().startswith('--'))
      lua.execute(lua_code)
      data: Any = lua.eval('ChimManagerSavedVars')
      ##########################################################################
      # TODO functionality placeholder
      self._string1 = "Top-level keys: " + ' '.join(str(k) for k in data.keys())
      logging.info(self._string1)
      # Example: print all character names for @BananaHell
      chars = data['Default']['@BananaHell']
      self._string2 = "Characters: " + ' '.join(str(k) for k in chars.keys())
      logging.info(self._string2)
      ##########################################################################
    except Exception as e:
      logging.error("Error reading file: %s", e)

  def get_latest_data(self) -> dict[str, str]:
    return {
        "string1": self._string1,
        "string2": self._string2
    }


class FileMonitor:
  """Monitors the current directory for changes to ChimManager.lua."""

  def __init__(self):
    self.path = "."
    self.handler = Handler()
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
