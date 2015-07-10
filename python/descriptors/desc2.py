# http://eev.ee/blog/2012/05/23/python-faq-descriptors/


class prop(object):
    def __init__(self, get_func):
        self.get_func = get_func

    def __get__(self, instance, owner):
        if instance is None:
            return self

        return self.get_func(instance)

    def __set__(self, instance, value):
        self.set_func(instance, value)
        return self

    def setter(self, set_func):
        self.set_func = set_func
        return self

    def set_func(self, instance, value):
        raise TypeError("can't see me")


class Demo(object):
    _value = None

    @prop
    def readwrite(self):
        return self._value

    @readwrite.setter
    def readwrite(self, value):
        self._value = value

    @prop
    def readonly(self):
        return 133

# test:
obj = Demo()
print(obj.readwrite)
obj.readwrite = 'foo'
print(obj.readwrite)
print(obj.readonly)
# # TypeError: can't see me:
# obj.readonly = 'bar'

# equals to:


class Demo2(object):
    _value = None

    def func1(self):
        return self._value

    def func2(self, value):
        self._value = value

    readwrite = prop(func1).setter(func2)
    # # works too
    # readwrite = property(func1).setter(func2)

obj2 = Demo2()
print(obj2.readwrite)
obj2.readwrite = 'foo'
print(obj2.readwrite)
