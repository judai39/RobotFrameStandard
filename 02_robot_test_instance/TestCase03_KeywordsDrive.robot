# 1、关键字驱动（类似与函数驱动）
*** Keywords ***
用户登录
    [Arguments]    ${username}    ${password}
    ${username_message}    输入用户名-返回邮箱形式    ${username}
    ${password_message}    输入密码    ${password}
    Log To Console    ${username_message}-${password_message}
    
输入用户名-返回邮箱形式
    [Arguments]    ${username}
    [Return]    ${username}@gmail.com

输入密码
    [Arguments]    ${password}
    [Return]    ${password}

*** Test Cases ***
UserLogin
    用户登录    username=tom    password=123