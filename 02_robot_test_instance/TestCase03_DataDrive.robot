# 2、数据驱动-使用[Template]
*** Test Cases ***
TestCase1
    [Template]    验证登录功能
    # 用户名    密码    期望结果
    admin    123    success
    admin2    123    fail
    admin3    122    success

*** Variables ***
${success}    success

*** Keywords ***
验证登录功能
    [Arguments]    ${username}    ${password}    ${expected_result}
    ${username_message}    输入用户名    ${username}
    ${password_message}    输入密码    ${password}
    IF    '${expected_result}' == '${success}'
        验证成功
    ELSE
        验证失败
    END

输入用户名
    [Arguments]    ${username}
    [Return]    ${username}@gmail.com
输入密码
    [Arguments]    ${password}
    [Return]    ${password}
验证成功
    Log To Console    登录成功
验证失败
    Log To Console    登陆失败