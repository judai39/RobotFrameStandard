.. code:: robotframework
*** Variables ***
${message}    Variables节中的变量
# 在命令行下，命令运行该文件
*** Test Cases ***
CASE01
    VAR    ${message}    用例中的变量
    Log To Console    this is test case${message}
    Log To Console    在user.py库中调用name值为:${name}


#通过套件名运行指定文件中的用例 robot -s "01 cmdline to run" 01_cmdline_to_run.robot
#变量约束传入变量给测试用例    robot --variable "message: str:this is magic" 01_cmdline_to_run.robot
# 如果要传入多个值，需要使用分号    --variable "myvariables.py;message: str:this is magic"
# 如果要传入的时library，需要使用variablefile参数 --variablefile .library/user.py .\00_AAATestSuite\01_cmdline_to_run.robot  

# 其他
# robot -d 输出目录 -o 输出文件.xml -l 日志文件.html -r 报告文件.html 测试文件路径
# 按标签执行测试文件    robot -i 标签名 测试文件路径
# 执行特定测试用例    robot -t case_01 测试文件路径

