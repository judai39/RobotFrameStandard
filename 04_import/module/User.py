from typing import OrderedDict

VARIABLE = "An example string"
ANOTHER_VARIABLE = "This is pretty easy!"
INTEGER = 42
STRINGS = ["one", "two", "kolme", "four"]
NUMBERS = [1, INTEGER, 3.14]
MAPPING = {"one": 1, "two": 2, "three": 3}

# 前缀LIST__、DICT__会被框架识别，调用该变量无需添加前缀
LIST__ANIMALS = ["cat", "dog"]
DICT__FINISH = OrderedDict([("cat", "kissa"), ("dog", "koira")])

# 类名与模块名一致与否将决定RF框架对其的封装
class user:
    # Variables user.py调用
    name="user_name"
    age=18
    _not_variable="从类属性创建_not_variable"
    def __init__(self,name):
        self.name=name
        self.instance_param="从实例属性创建instance_param"
    def get_user_instance_name(self):
        return self.name
User=user("user_intance")
