*** Settings ***
Library    ../.venv/Lib/site-packages/robot/libraries/OperatingSystem.py
# 通过不同的方式创建变量
*** Variables ***
# 1、创建标量值
${NAME}    Robot Framework
${VERSION}=    2.0
${Robot}    ${NAME} ${VERSION}
# 使用separator配置选项输出较长的标量值
${longlonglenth}    {FIRST LINE
...    SECONDLINE
...    THRDLINE}
${${随便}}    VAR设置列表占位用
# VAR    NUM    2    2类型为string
${2}    #${2}类型为integer
${true}
${false}
${None}
# 空格变量
${Empty}
${SPACE}
${SPACE * 2}

# 2、创建列表
# 变量声明必须使用@
@{NAMES}    NATTI    TEPPO
@{NAMES}    @{NAMES}    SEPPO
@{NOTHING}
@{MANY}        {ONE    TWO    
...    THREE    FOUR}

# 3、创建字典
# 变量声明必须使用&，键值对形式必须使用key=value的形式
&{USERS}    NAME1=MATTI    NAME2=NANCY    NAME2\=2EMAN=TOM    2=two

# 4、赋值列表，字典中的变量元素

# 5、多变量赋值

# 6、VAR关键字创建所有变量元素(创建列表或字典时变量声明要使用@,&),VAR关键字声明还支持修改作用域

# 7、条件创建变量
# VAR 语法与 IF/ELSE 结构配合使用，可以方便地条件性创建变量。在简单情况下，使用内联 IF 会很方便。

# 8、变量类型转换（不同类型的数据，包括python支持的类型，想要被RF感知需要转换为RF下的类型）
# 变量转换仅在创建变量时支持，在使用变量时不支持
# ！！！！！为什么需要？        --->导入外部库，一般为python文件，一些python的变量诸如[]、{}与RF框架不适用，所以需要转化
# 8.1、@{list}和&{dict}的类型转换
@{NUMBERS: int}    1    2    3    4    5
&{DATES: date}    rcl=2026-05-08    final=2026-05-30
&{PRIORITIES: int=str}    3278=Critical    4134=High    5334=High
# 8.2、通过创建${scalar}变量，使用list和dict类型进行约束以实现对list、dict的创建
${NUMBERS: list[int]}    [1,2,3,4,5]
${DATES: date}    {'rcl'='2025-06-06'    'final'='2025-06-21'}
${PRIORITIES: dict[int,str]}    {3278:'Critical',4173:'High',5334:'High'}
# 使用${scalar}变量约束类型，好处主要是可以无需使用临时值，通过嵌套创建列表或数组

# 9、RF内置变量




*** Test Cases ***
CASE01
    Log To Console    ${longlonglenth}
CASE03
    # 关于字典
    Log To Console    通过字典名.key可以直接访问value值${USERS.NAME2}
    Log To Console    但是不能访问key值为常数的键值对${USERS.2},提示‘SyntaxError: invalid syntax’，尝试使用违法下标进行访问，系统优先将2识别为下标而非key值
CASE04
    # 赋值列表中的变量元素
    ${list}=    Create List    1    2    3    4
    ${list}[0]    Set Variable    first
    ${list}[-1]    Set Variable    last
    # 赋值字典中的变量元素
    ${dict}=    Create Dictionary    first_key=unknown
    ${dict.first_key}=    Set Variable    John
    ${dict.last_key}=    Set Variable    Mike
CASE05
    # 多变量赋值
    ${a}    ${b}    ${c}    Get THREE
    @{args}    Get THREE
    Log To Console    ${args}
    ${value1}    @{args}    Get THREE
    Log To Console    ${value1}and@{args}
    @{args}    ${value1}    Get THREE
    Log To Console    ${args}and${value1}
CASE06
    # 使用VAR关键字替代CREATE LIST 、CREATE VARIABLES，语法规范上即为Var加Variables节语法
    VAR    ${variable}    variable1
    VAR    @{two items}    Robot    Frame
    # 直接调用two items会报错，需要在variables节中声明${${NAME}}
    Log To Console    ${two items}
    VAR    &{two dicts}    name1=Robot    name2=Frame

    # 一般情况下，在用例模块中声明的变量为局部变量，但是VAR关键字支持修改变量作用域，使其变为全局变量等其他变量
    # 非局部变量名称建议小写
    VAR    ${local}    local value    #当前用例可访问
    VAR    ${TEST}    test value    scope=TEST
    VAR    ${SUITE}    suite value    scope=SUITE
    VAR    ${SUITES}    nested suite value    scope=SUITES
    VAR    ${GLOBAL}    global value    scope=GLOBAL
    Keyword
    Should Be Equal    ${TEST}      new test value
    Should Be Equal    ${SUITE}     new suite value
    Should Be Equal    ${SUITES}    new nested suite value
    Should Be Equal    ${GLOBAL}    new global value

# 试着将CASE06以外的所有用例注释掉，一次性运行CASE06的两个用例，可以发现Should Be Equal    ${TEST}      new test value返回false，也就是说CASE06声明的${TEST}作用域不会与其他用例共享，符合
CASE06_Add_Test
    # Should Be Equal    ${TEST}      new test value
    Should Be Equal    ${SUITE}     new suite value
    Should Be Equal    ${SUITES}    new nested suite value
    Should Be Equal    ${GLOBAL}    new global value

CASE07
    # IF语法
    IF    "${NAME}"=="Robot Framework"
        VAR    ${ADDRESS}    127.0.0.1
        VAR    ${DEMO}    demo
    ELSE
        VAR    ${ADDRESS}    192.168.1.42
        VAR    ${DEMO}    DEMO
    END
    # 内联IF(没有end)
    IF    "${NAME}"=="Robot framework"    VAR    ${ADDRESS}    127.0.0.1    ELSE    VAR    ${ADDRESS}    192.168.1.42

CASE08
    VAR    ${number: int}    42
    Should Be Equal    ${number}    ${42}
    # 通过创建${scalar}变量约束以实现list和dict的创建
    ${numbers: list[int]}    Evaluate    [1,2,3,4,5]

CASE09
    # RF内置变量
    Log To Console    测试数据文件所在目录的绝对路径${CURDIR}
    Log To Console    系统临时目录的绝对路径${TEMPDIR}
    Log To Console    测试执行启动所在目录的绝对路径${EXECDIR}
    Log To Console    系统目录路径分隔符${/}
    Log To Console    系统路径元素分隔符${:}
    Log To Console    系统换行符${\n}
    

    
    




*** Keywords ***
Get THREE
    &{list}    Create Dictionary    key1=value1    key2=value2    key3=value3
    [Return]    ${list}

Keyword
    Should Be Equal    ${TEST}      test value
    Should Be Equal    ${SUITE}     suite value
    Should Be Equal    ${SUITES}    nested suite value
    Should Be Equal    ${GLOBAL}    global value
    VAR    ${TEST}      new ${TEST}      scope=TEST
    VAR    ${SUITE}     new ${SUITE}     scope=SUITE
    VAR    ${SUITES}    new ${SUITES}    scope=SUITES
    VAR    ${GLOBAL}    new ${GLOBAL}    scope=GLOBAL
    Should Be Equal    ${TEST}      new test value
    Should Be Equal    ${SUITE}     new suite value
    Should Be Equal    ${SUITES}    new nested suite value
    Should Be Equal    ${GLOBAL}    new global value