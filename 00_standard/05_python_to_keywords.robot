# 拓展关键字允许robot frame框架读取外部的python文件中的函数作为第三方库导入框架
*** Settings ***
Library    MyLibrary.py    "host"    "port"
# 类需要单独导入声明

*** Test Cases ***
case1
    ${port_var}    ReturnPort    #returnPort()转为关键字为ReurnPort
    ${host_var}    ReturnHost
    Log To Console    ${host_var}
    Log To Console    ${port_var}
