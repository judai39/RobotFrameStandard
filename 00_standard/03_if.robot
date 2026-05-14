*** Variables ***
${expected_result}    success
${success}    success
*** Test Cases ***
TestCase1
    # 不添加''对变量进行修饰,无法比较成功
    IF    '${expected_result}' == '${success}'
            Log To Console    success
    ELSE
            Log To Console    fail
    END