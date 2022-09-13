import time 
from threading import Thread

def factorize(number):
    for i in range(1, number + 1):
        if number % i == 0:
            yield i

def pattern_1():
    numbers = [124124, 124124124, 5325326, 412414]
    start = time.time()

    def factorize(number):
        for i in range(1, number + 1):
            if number % i == 0:
                yield i

    for number in numbers:
        list(factorize(number))

    elappsed_time = time.time() - start
    print(elappsed_time)


class FactorizeThread(Thread):
    def __init__(self, number):
        super().__init__()
        self.number = number
    
    def run(self):
        self.factors = list(factorize(self.number))

def pattern_2():
    start = time.time()
    threads = []
    numbers = [124124, 124124124, 5325326, 412414]
    for number in numbers:
        thread = FactorizeThread(number)
        thread.start()
        threads.append(thread)
    elapssed_time = time.time() - start
    print(elapssed_time)
    

def main():
    pattern_1()
    pattern_2()

if __name__ == '__main__':
    main()
