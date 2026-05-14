from robot.running import TestSuite

# 绝对路径读取数据为suite套件
suite=TestSuite.from_file_system("C:/Users/dkf11651/Desktop/RFProject/01_data_format/TestCase01_WithSpaceSeparated.robot")

"""套件转换为json"""
# 使用默认参数方法输出suite套件的数据（转化为json的）
data1=suite.to_json()
# 使用带参方法输出suite套件数据（自定义缩进为2，并保存为data。rbt）
data2=suite.to_json("data.rbt",indent=2)

"""json转换为套件"""
suite=TestSuite.from_json('data.rbt')

suite.run()#使用run方法，输出log模式为默认（就不会输出在配置好的logs文件夹中，且只会输出默认的output.xml文件，没有report和log）