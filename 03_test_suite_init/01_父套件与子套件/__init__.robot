# 测试套件初始化的名称一般为__init__.robot，该文件会在加载其他robot文件前加载，用于初始化变量
# 套件初始化文件一般包含以下
*** Settings ***
Documentation    这是一个套件初始化文件
# 访问通过使用RunKeywords关键字运行多个关键字实现实例化
Suite Setup    Run Keywords
...    Claim
...    AND    InitialVariables
...    AND    Do Something
Test Tags    TestCase
# 这里是测试套件名称，可以自由声明
# Name    CustomSuiteName
Suite Teardown    Log To Console    清理套件数据。。。
# 测试套件中的自由元数据
Metadata        Version            2.0
Metadata        Robot Framework    http://robotframework.org
Metadata        Platform           ${PLATFORM}

*** Variables ***
${MESSAGES}    这是全局套件配置

*** Keywords ***
Claim
    Log To Console    初始化套件。。。
Do Something
    [Arguments]    ${args}=0
    Log To Console    套件已完成初始化
    RETURN    ${args}
InitialVariables
    Set Global Variable    ${MESSAGES}
# 访问子套件中的全局变量--失败
# Claim From Son Suite
#     Log To Console    ${SUITE_VAR}