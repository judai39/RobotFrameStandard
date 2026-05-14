*** Settings ***
Library    Process

*** Variables ***
${value1}    string
${listvalue}    Create List    1 2 3 4

*** Keywords ***
KeywordsCase1
    [Arguments]    ${arg1}=1    ${arg2}=1    ${arg3}=1
    Log To Console    ${arg1}and${arg2}and${arg3}
KeywordsCase2
    [Arguments]    @{args}
    Log To Console    @{args}
KeywordsCase3
    [Arguments]    @{args}    ${value}    #${value}为仅限命名参数
    Log To Console    @{args}and仅限命名参数${value}

*** Test Cases ***
# 1、关于命名参数
# 命名参数允许在参数前添加“参数名=”的方式，让指定关键字参数赋值
# 这意味着，如果我们在调用关键字时只希望调用某个自定义参数而其他参数为默认时，就可以直接使用命名参数
TestCase1
    KeywordsCase1    arg2=0
    # 如果传入一个参数名称中没有参数，“参数名=”将会被识别成字符串
    KeywordsCase1    arg=0

# 2、带变量的命名参数
TestCase2
    KeywordsCase1    arg1=${value1}
    KeywordsCase2    args=${listvalue}    #当前的编译类型为Create List 1...（@{}类型），传入Evaluate [1,2,3]（list类型）无法通过编译

# 3、仅限命名参数
TestCase3
    KeywordsCase3    args=2    2    value=3    #['args=2', '2']and仅限命名参数3
    

