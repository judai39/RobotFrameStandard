*** Settings ***
# 3、外部测试库创建的关键字
Library    ../../.library/TestLibrary.py
# 2、资源文件中的关键字
Resource    ../../.resource/test_resource.robot

*** Test Cases ***
Case01
    Should Be Equal    ${1}    ${2}
    
*** Keywords ***
# 1、用户关键字
Should Be Equal
    [Arguments]    ${num1: int}    ${num2: int}
    Log To Console    这是用户关键字，最高优先级

