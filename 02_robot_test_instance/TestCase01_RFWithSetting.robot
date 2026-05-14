*** Test Cases ***
# 1、tags用法
Testcase1
    [Documentation]    Another dummy test
    [Tags]    dummy    owner-haoyudu
    Log    Hello,world!
Testcase2
    [Documentation]    Another dummy test
    [Tags]    dummy    owner-haoyudu
    Log    Hello,world!
Testcase3
    [Documentation]    Another dummy test
    [Tags]    dummy    owner-haoyudu
    Log    Hello,world!
Testcase4
    [Documentation]    Another dummy test
    [Tags]    dummy    owner-小明
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

# 2、初始化与清理用法
Default values
    [Documentation]    Setup and teardown from setting section
    Log To Console    "将会使用settings中的默认test setup事件"
Using variables
    [Documentation]    Setup and teardown specified using variables
    [Setup]    Open Application    App B
    Log To Console    "使用自定义事件"
    [Teardown]    Close All Applications

# 3、测试模板用法
Normal TestCase
    # 可以通过这种方法拿返回值，模板创建是拿不到的
    ${sum}    sum_keywords    arg1=5    arg2=5

使用sum_keywords关键字模板创建
    [Template]    sum_keywords
    arg1=5    arg2=5

使用for_keywords关键字模板创建
    [Template]    for_keywords
    1    2    3    4    5
    apple    bnana    orange


*** Settings ***
Library    ../.venv/Lib/site-packages/SeleniumLibrary/__init__.py
Library    ../.venv/Lib/site-packages/AppiumLibrary/__init__.py
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