# 通过变量动态指定setup/teardown关键字，实现命令行控制指定setup，teardown行为
*** Settings ***
Suite Setup    ${SUITE_SETUP_KEYWORD}
Suite Teardown    ${SUITE_TEARDOWN_KEYWORD}
Test Setup    ${TEST_SETUP_KEYWORD}
Test Teardown    ${TEST_TEARDOWN_KEYWORD}
Library    ../../.venv/Lib/site-packages/SeleniumLibrary/__init__.py

*** Variables ***
# 使用变量指向关键字
${SUITE SETUP KEYWORD}    Default Suite Setup
${SUITE_TEARDOWN_KEYWORD}    Default Suite Teardown
${TEST_SETUP_KEYWORD}    Default Test Setup
${TEST_TEARDOWN_KEYWORD}    Default Test Teardown


*** Keywords ***
Default Suite Setup
    Log    默认套件初始化
    Log To Console    执行默认套件初始化

Default Suite Teardown
    Log    默认套件清理
    Log To Console    执行默认套件清理

Default Test Setup
    Log    默认测试初始化

Default Test Teardown
    Log    默认测试清理

Fast Test Setup
    Log    快速测试初始化（跳过日志）
    Set Log Level    NONE

Detailed Test Setup
    Log    详细测试初始化
    Set Log Level    DEBUG

Custom Setup
    Log    自定义初始化
    Open Browser    chrome
    Maximize Browser Window

Custom Teardown
    Log    自定义清理
    Close All Browsers

*** Test Cases ***
Case01
    Log To Console    this is magic


# # 使用默认的setup/teardown
# robot TestCase01.robot

# # 使用快速测试初始化
# robot --variable TEST_SETUP_KEYWORD:FastTestSetup TestCase01.robot

# # 使用详细测试初始化
# robot --variable Suite_SETUP_KEYWORD:DetailedTestSetup TestCase01.robot

# # 同时修改多个参数
# robot --variable SUITE_SETUP_KEYWORD:CustomSetup --variable SUITE_TEARDOWN_KEYWORD:CustomTeardown TestCase01.robot

# # 使用不同的浏览器配置
# robot --variable TEST_SETUP_KEYWORD:"Open Browser And Login" --variable BROWSER:firefox TestCase01.robot