import logging
import sys


class ErrorHandler(logging.StreamHandler):
    def __init__(self):
        super().__init__(sys.stderr)
        self.setLevel(logging.ERROR)
