*** Test Cases ***
# 1、tags用法
Testcase1
    [Documentation]    Panshu的测试用例
    [Tags]    CASE_NO=T129_P23639    Panshu
    Log    Hello,world!
Testcase2
    [Documentation]    Hygon的测试用例(基本功能)
    [Tags]    Basic    CASE_NO=T129_P8803    Hygon
    Log    Hello,world!
Testcase3
    [Documentation]    AMD的测试用例
    [Tags]    weight=3.0    CASE_NO=T129_P19350    AMD
    Log    Hello,world!
# 尝试命令行执行
# 只执行smoke标签的测试
# robot --include smoke tests/
# 排除regression标签的测试
# robot --exclude regression tests/
# 执行多个标签的测试
# robot --include smokeORregression tests/
# 组合条件
# robot --include critical --exclude wip tests/

# 除此之外，可以在.vscode/launch.json中配置参数，方便调试

# 2、初始化与清理用法
Default values
    [Documentation]    Setup and teardown from setting section
    Log To Console    "将会使用settings中的默认test setup事件"
Using variables
    [Documentation]    Setup and teardown specified using variables
    [Setup]    Open Application    http://localhost:4723    Android
    Log To Console    "打开安卓应用应用"
    [Teardown]    Close All Applications

# 3、测试模板用法
Normal TestCase
    # 可以通过这种方法拿返回值，模板创建是拿不到的
    ${sum}    sum_keywords    arg1=5    arg2=5
    # 这时候有人要问了，拿不到返回值为什么还要用呢？
    # 模板创建是为了用一堆数据批量测试模板方法的--数据驱动
    # 用以下两个举例

使用sum_keywords关键字模板创建
    # 我希望测试seum_keywords方法的正确性，传入不同的参数，看看返回值是否正确(优势在于，不管有多少数据，只需要在模板中写一行就可以了)
    [Template]    sum_keywords
    arg1=5    arg2=5

使用for_keywords关键字模板创建
    [Template]    for_keywords
    1    2    3    4    5
    apple    bnana    orange


*** Settings ***
Library    SeleniumLibrary
Library    AppiumLibrary
# Test Setup    Open Application    App A
# Test Teardown    Close All Applications

*** Keywords ***
sum_keywords
    [Arguments]    ${arg1}=0    ${arg2}=0
    ${sum}    Evaluate    ${arg1}+${arg2}
    [Return]
for_keywords
    [Arguments]    @{ITEMS}
    FOR    ${item}    IN    @{ITEMS}
        Log To Console    ${item}
    END