*** Test Cases ***
CASE01
    用户关键字超时必须要有默认值
*** Keywords ***
用户关键字超时必须要有默认值
    # [Arguments]    ${time}    也可以选择在关键字参数传入超时时间
    [Timeout]    1 minute 42 seconds
    loop
loop
    WHILE    $True
        Log To Console    this is loop
    END