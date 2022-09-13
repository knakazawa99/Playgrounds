from threading import Thread, Lock


class Counter:
    def __init__(self) -> None:
        self.count = 0

    def increment(self, offset):
        self.count += offset

class LockingCounter():
    def __init__(self) -> None:
        self.lock = Lock()
        self.count = 0

    def increment(self, offset):
        with self.lock:
            self.count += offset
        
def worker(sensor_index, how_many, counter):
    for _ in range(how_many):
        counter.increment(1)
    

def non_lock_pattern():
    how_many = 10 ** 8
    counter = Counter()
    threads = []
    for i in range(5):
        thread = Thread(target=worker, args=(i, how_many, counter))
        threads.append(thread)
        thread.start()
    for thread in threads:
        thread.join()
    expected = how_many * 5
    found = counter.count
    print(f'Counter should be {expected}, got {found}')


def lock_pattern():
    how_many = 10 ** 8
    counter = LockingCounter()
    threads = []
    for i in range(5):
        thread = Thread(target=worker, args=(i, how_many, counter))
        threads.append(thread)
        thread.start()
    for thread in threads:
        thread.join()
    expected = how_many * 5
    found = counter.count
    print(f'Counter should be {expected}, got {found}')

def main():
    # counter = Counter()
    # worker(1, 2, counter)
    # 10**5くらいから、Lock しないとずれるようになる, lockすると当然だが、処理は長くなる。
    # macでは再現できなかったが、paizaで行うと再現できた
    non_lock_pattern()
    lock_pattern()
if __name__ == '__main__':
    main()
