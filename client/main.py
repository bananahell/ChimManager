import logging
from threading import Thread
from typing import Callable, NoReturn
from connection_maker import start_connection
from window_manager import run_window


def configure_logging() -> None:
  """Configure application logging with timestamp and level formatting."""
  logging.basicConfig(
      level=logging.INFO,
      format='%(asctime)s - %(levelname)s - %(message)s',
      datefmt='%Y-%m-%d %H:%M:%S',
      handlers=[
          logging.StreamHandler(),  # Console output
      ]
  )


def launch_background_service(target: Callable[[], None]) -> Thread:
  """Initialize and start a background service thread.
  Args:
      target: Callable to execute in the background thread
  Returns:
      Thread: The started thread instance
  """
  service_thread = Thread(
      target=target,
      daemon=True,
      name="BackgroundService"
  )
  service_thread.start()
  return service_thread


def main() -> NoReturn:
  """Application entry point coordinating service startup and UI."""
  configure_logging()
  logger = logging.getLogger(__name__)
  logger.info("Initializing ChimManager client")
  try:
    launch_background_service(start_connection)
    run_window()
  except Exception as error:
    logger.critical("Fatal application error: %s", error, exc_info=True)
    raise SystemExit(1) from error
  logger.info("Application terminated normally")
  raise SystemExit(0)


if __name__ == '__main__':
  main()
