from distutils.log import debug
from threading import Lock

lock = Lock()
with lock:
    print('gagd')

from contextlib import contextmanager
import logging

@contextmanager
def debug_logging(level):
    logger = logging.getLoger()
    old_level = logger.getEffectiveLevel()
    logger.setLevel(level)
    try:
        yield
    finally:
        logger.setLevel(old_level)

def my_function():
    print('sese')

def main():
    with debug_logging(logging.DEBUG):
        print('* Inside: ')
        my_function()

if __name__ == '__main__':
    main()