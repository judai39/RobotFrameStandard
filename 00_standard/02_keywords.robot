*** Settings ***
Library    SeleniumLibrary
*** Test Cases ***
ADDTest
    ${sum}    add    1    1
    Log To Console    ${sum}
    # 创建type变量，将sum类型赋值给type
    ${type}=    Evaluate    type(${sum}).__name__
    Log To Console    ${type}

ADDMemberTest
    ${sum}    add_members    1    2    3    4
    Log To Console    ${sum}

TestKwargs
    ${dict}    Create Dictionary    name=haoyudu    age=19    sex=男
    Kwargs Only    &{dict}
    Positional And Kwargs    123    &{dict}
    
    

*** Keywords ***
# 1、Library库自带的关键字（函数）
Open Login Page
    Open Browser    http://www.baidu.com

# 2、自定义第三方关键字（函数）
add
    [Arguments]    ${a}=0    ${b}=0    #=0意为默认值为0
    ${sum}    Evaluate    ${a}+${b}
    [Return]    ${sum}
    [Tags]    add_function
    [Teardown]    Log To Console    该TestCase已完成

# 3、关于包含可变参数的关键字
add_members
    [Arguments]    ${req1}=0    ${req2}=0    @{otherargs_list}  #@{otherargs_list}为一个list类型???    --不是list类型，是一个专属与rf框架的“多参数”类型
    # 使用for循环遍历取出值
    ${sum}    Evaluate    ${req1}+${req2}
    FOR    ${item}    IN    @{otherargs_list}
        ${sum}    Evaluate    ${item}+${sum}
    END
    # [Return]    ${req1}+${req2}+${sum}    Return语句不能写成算数式，会被认为是string
    [Return]    ${sum}

# 4、关于包含关键字参数的关键字-->鸭子模型
Kwargs Only
    [Arguments]    &{kwargs}
    # 打印信息到log.html中
    Log    ${kwargs}
    Log Many    &{kwargs}
Positional And Kwargs
    [Arguments]    ${required}    &{extra}
    # 打印信息到控制台中
    Log To Console    ${required}    &{extra}
    # 打印更多信息到log.html中
    Log Many    ${required}    &{extra}
