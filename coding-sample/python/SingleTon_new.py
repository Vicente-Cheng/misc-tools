#!/usr/bin/python3
#
# Sample for SingleTon with `__new__`
#

class SingleTon:
    _inst = None
    def __new__(cls, *args, **kwargs):
        if cls._inst is None:
            cls._inst = super().__new__(cls)
        return cls._inst

class Foo(SingleTon):
    def __init__(self, a):
        self.a = a

    def printout(self):
        print("output a: {}".format(self.a))

class Bar(object):
    def __init__(self, b):
        self.b = b

    def printout(self):
        print("output b: {}".format(self.b))
