from robot.running import ResourceFile

# 使用以下代码将json文件转换成resource文件

# 基于文件系统中的数据创建资源文件
resource = ResourceFile.from_file_system(r'C:\Users\dkf11651\Desktop\RFProject\.resource\resource.robot')

# 保存 JSON 数据到文件
resource.to_json(r'C:\Users\dkf11651\Desktop\RFProject\.resource\resource.rsrc')

# 从 JSON 数据重建资源文件
# resource = ResourceFile.from_json('example.rsrc')