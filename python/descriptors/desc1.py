# http://eev.ee/blog/2012/05/23/python-faq-descriptors/

# this
class prop(object):
    def __init__(self, get_func):
        self.get_func = get_func

    def __get__(self, instance, owner):
        if instance is None:
            return self

        return self.get_func(instance)


class Demo(object):
    @prop
    def attribute(self):
        return 133


# equals to
def getter(self):
    return 133


class Demo2(object):
    attribute = prop(getter)


# test:
print(Demo().attribute)
print(Demo2().attribute)