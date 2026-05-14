class MyObject:

    def __init__(self,name):
        self.name = name

    def eat(self, what):
        return f'{self.name} eats {what}'

    def __str__(self):
        return self.name
    
OBJECT = MyObject("john")
# DICTIONARY = {1: 'one', 2: 'two', 3: 'three'}
# print(OBJECT.name)