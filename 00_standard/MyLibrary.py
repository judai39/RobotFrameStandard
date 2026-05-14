class MyLibrary:
    # RF框架会直接创建实例对象，在取方法时直接调用类方法名称即可(如果初始化需要传参，则在settings中需要加上参数)
    def __init__(self,host:str,port:str):
        self.host=host
        self.port=port
        print("LibraryClass already inited...")
    
    def returnPort(self):
        return self.port
    
    def returnHost(self):
        return self.host

    # 以下划线开头的函数不能作为RF关键字
    def _returnlist2(self):
        return [1, 2]

    
