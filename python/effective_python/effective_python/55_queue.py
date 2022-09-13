from asyncore import poll
from collections import deque
from re import M
from threading import Lock, Thread
import time


def download(item):
    print(f'download: {item}')
    time.sleep(0.1)

def resize(item):
    print(f'resize: {item}')
    time.sleep(0.1)

def upload(item):
    print(f'upload: {item}')
    time.sleep(0.1)


class MyQueue:
    def __init__(self) -> None:
        self.items = deque()
        self.lock = Lock()
    
    def put(self, item):
        with self.lock:
            self.items.append(item)

    def get(self):
        with self.lock:
            return self.items.popleft()

class Worker(Thread):
    def __init__(self, func, in_queue, out_queue) -> None:
        super().__init__()
        self.func = func
        self.in_queue = in_queue
        self.out_queue = out_queue
        self.polled_count = 0
        self.work_down = 0

    def run(self):
        while True:
            self.polled_count += 1
            try:
                item = self.in_queue.get()
            except IndexError as e:
                time.sleep(0.01)
            else:
                result = self.func(item)
                self.out_queue.put(result)
                self.work_down += 1

download_queue = MyQueue()
resize_queue = MyQueue()
upload_queue = MyQueue()
done_quque = MyQueue()
threads = [
    Worker(download, download_queue, resize_queue),
    Worker(resize, resize_queue, upload_queue),
    Worker(upload, upload_queue, done_quque),
]

for thread in threads:
    thread.start()

for _ in range(100):
    done_quque.put('Hello')

while len(done_quque.items) < 100:
    print('wait here!!')
    time.sleep(0.5)

processed = len(done_quque.items)
polled = sum(t.polled_count for t in threads)
print(f'Processed {processed}, polling: {polled}')