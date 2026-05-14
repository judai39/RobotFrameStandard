*** Settings ***
# settings节设置用例超时时间
Test Timeout    5 seconds

*** Test Cases ***
使用Settings中的默认超时
    loop

用例超时覆盖settings节超时（如果不设置或声明为NONE只声明标签，也会覆盖，覆盖为不使用超时）
    [Timeout]    3 seconds
    loop
    

*** Keywords ***
loop
    WHILE    $True
        Log To Console    this is loop
    END