# 如何导入外部资源？
*** Settings ***
# Settings中引入
Resource    resource.robot

*** Test Cases ***
Resource Import Test
    Log To Console    ${URL}
    Open Login Page    https://https://re.m.jd.com/    Edge