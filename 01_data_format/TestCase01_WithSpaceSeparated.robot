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
    # ${CURDIR} → 当前目录
    My Keyword    ${CURDIR}

Another Test
    [Documentation]    一些特殊语义字符
    # \t → 制表符
    # \xA0 → 不间断空格
    # ${SPACE} → 一个空格
    # ${EMPTY} → 空字符串 ""
    Log    I\thave\xA0a${SPACE}apple${EMPTY}juice

*** Keywords ***
My Keyword
    [Arguments]    ${path}
    Directory Should Exist    ${path}