# 正常情况下，类名（User）需要和文件名一致才能被正确导入将里面的函数作为关键字传入
class User:
    name="mingzi"
    def __init__(self):
        pass
    def get_user_name(self):
        return self.name
# 有实例化类对象可被Variables引入成为变量，实例对象的名称需要严格约束与类相同
User=User()