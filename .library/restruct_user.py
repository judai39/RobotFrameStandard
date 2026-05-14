class restruct_user:
    name="mingzi"
    def __init__(self):
        pass
    def get_user_name(self):
        return self.name
    def return_restruct_user(self):
        # 将实例化操作内敛进成员方法
        return restruct_user()