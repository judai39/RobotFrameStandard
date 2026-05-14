*** Settings ***
Documentation     使用空格符作为分割符
Library           OperatingSystem
Library    String

*** Variables ***
${MESSAGE}        Hello, world!

*** Test Cases ***
My Test
    [Documentation]    Example test.
    Log    ${MESSAGE}
    My Keyword    ${CURDIR}

Another Test
    [Documentation]    如果需要将制表符或者空格符作为参数传入(empty为何失效)
    Log    I\thave\xA0a${SPACE}apple${EMPTY}juice

*** Keywords ***
My Keyword
    [Arguments]    ${path}
    Directory Should Exist    ${path}