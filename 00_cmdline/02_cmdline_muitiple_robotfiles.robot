# 使用命令行运行robot，可以清晰的指定固定版本的PIP对应的RF框架运行robot文件

# 1、指定待执行的测试数据
robot tests.robot
robot path/to/my_tests/
robot c:\robot\tests.robot
当指定多个文件执行测试时，RF会自动创建顶层测试套件，指定的文件和目录会成为其子测试套件。顶层套件名为“子套件名1 & 子套件名2。。。。”，自动创建的套件名称过于冗长，使用--name 套件名替代
如果指定的为目录，顶层套件为目录名

可以为自动创建的顶层套件指定一个已创建的__init__.robot文件，用来声明套件结构

# 2、指定选项值执行测试用例
# 必须始终放在运行脚本和数据源之间
许多命令行选项接受简单模式作为参数。这些类 glob 模式按照以下规则匹配：
    * 匹配任意字符串，包括空字符串。
    ? 匹配任意单个字符。
    [abc] 匹配括号中的一个字符。
    [!abc] 匹配不在括号中的一个字符。
    [a-z] 匹配括号中范围内的一个字符。
    [!a-z] 匹配不在括号中范围内的一个字符。
与通常的 glob 模式不同，路径分隔符 / 和 \ 以及换行符 \n 可以被上述通配符匹配。
除非另有说明，模式匹配是大小写、空格和下划线不敏感的。
示例：
--test Example*        # 匹配名称以 'Example' 开头的测试。
--test Example[1-2]    # 匹配测试 'Example1' 和 'Example2'。
--include f??          # 匹配带有以 'f' 开头且长度为三个字符的 tag 的测试。
robot --test *Case02* temp    #运行Case02结尾的测试文件

# 3、Tag模式--支持接收简单模式作为参数
--include fooANDbar     # 匹配包含 tag 'foo' 和 'bar' 的测试。
--exclude xx&yy&zz      # 匹配包含 tag 'xx'、'yy' 和 'zz' 的测试。
--include fooORbar      # 匹配包含 tag 'foo' 或 tag 'bar' 的测试。
--exclude xxORyyORzz    # 匹配包含 tag 'xx'、'yy' 或 'zz' 中任意一个的测试。
--include fooNOTbar     # 匹配包含 tag 'foo' 但不包含 tag 'bar' 的测试。
--exclude xxNOTyyNOTzz  # 匹配包含 tag 'xx' 但不包含 tag 'yy' 或 tag 'zz' 的测试。


# 4、声明临时环境变量    --export为shell命令，windows下不可用
export ROBOT_OPTIONS="--outputdir results --tagdoc 'mytag:Example doc with spaces'"
robot tests.robot
export REBOT_OPTIONS="--reportbackground blue:red:yellow"
rebot --name example output.xml