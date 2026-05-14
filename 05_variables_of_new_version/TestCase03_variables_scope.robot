*** Variables ***
${message}    Variables节中的变量
# 10、变量优先级
# 命令行中的--variable    >>    *** Variables ***节    >>    settings中导入的Library或Resource    
# 此外，在测试执行期间设置的变量，在其作用域中，具有最高优先级，不会影响作用域之外的变量
# 此外，像${TEMPDIR}这种内置变量具有所有变量中的最高优先级，不可被覆盖（原则上来说，这些变量象征着操作系统的一些默认值，不能被修改，即使可以修改，也不要去尝试修改）

# 11、变量作用域
# 全局作用域：使用命令行--variable选项设置，也可以使用VAR关键字声明scope为GLOBAL，作用范围为不同套件之间都可以共享
# 测试套件作用域：在Variables节中创建，或者在settings中的Resouce或Library中导入，作用范围为整个套件中都可用
# 测试用例作用域：只在当前用例中可用


*** Test Cases ***
CASE10
    VAR    ${message}    用例中的变量
    Log To Console    this is test case${message}
# 尝试命令行运行以下命令
# robot  --variable "message: str:命令行设置变量" 05_variables_of_new_version/TestCase03_variables_parameter.robot

CASE11
    VAR    ${variables1}    CASE11用例中的变量    scope=Test
    # 也可以使用Set Test Variable
    Keywords11

    # -->查看settings中的Suite Setup和Suite Teardown
    # 套件初始化中创建的值，用例无法访问
    Log To Console    ${suite_setup_var}


*** Keywords ***
Keywords11
    Log To Console    在关键字被调用后，关键字可以访问到调用该关键字的测试用例中的变量${variables1}

套件初始化
    Log    执行套件初始化
    # 在Suite Setup中创建测试作用域变量
    VAR    ${suite_setup_var}    Suite Setup value    scope=Test
    Log    在Suite Setup中: ${suite_setup_var}    # 输出: 在Suite Setup中: Suite Setup Value
    
    # 这个变量只在Suite Setup和对应的Suite Teardown中可见
    Set Suite Variable    ${global_var}    全局变量    # 使用套件作用域让所有测试可见

套件清理
    Log    执行套件清理
    # 在Suite Teardown中可以访问Suite Setup中创建的测试作用域（scope=test）变量
    Log    在Suite Teardown中: ${suite_setup_var}    # 输出: 在Suite Teardown中: Suite Setup Value
    
    # 在Suite Teardown中创建的测试作用域变量只在此处可见
    VAR    ${teardown_var}    Teardown Value
    Log    ${teardown_var}    # 输出: Teardown Value

*** Settings ***
Suite Setup     套件初始化
Suite Teardown  套件清理