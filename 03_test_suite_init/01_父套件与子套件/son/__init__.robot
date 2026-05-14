# 该__init__.robot文件将会继承父套件中的__init__.robot中的变量和关键字
*** Settings ***
Resource    ../__init__.robot
Documentation    套件初始化文件
Suite Setup      Run Keywords    Get Suite Value    AND    InitialVariables    AND    Access Parent Variable

*** Variables ***
# 套件级变量
${SUITE_VAR}    Hello from __init__
${ANOTHER_VAR}    42
@{LIST_VAR}    Create List    a    b    c

*** Keywords ***
Get Suite Value
    [Return]    ${SUITE_VAR}

InitialVariables
    Set Global Variable    ${SUITE_VAR}
    Set Global Variable    ${ANOTHER_VAR}
    Set Global Variable    ${LIST_VAR}

Access Parent Variable
    #访问父套件的变量（父套件访问权限需大于Suite）
    Log To Console    ${MESSAGES}