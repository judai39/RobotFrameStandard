*** Test Cases ***
Example
    VAR    ${RC}    1
    WHILE    ${RC}!=1
        Log To Console    "error"
    END
限制WHILE循环迭代次数
    WHILE    $True    limit=100
        Log To Console    this is run 100 times
    END
    WHILE    $True    limit=10 times
        Log To Console    this is run 10 times
    END
    WHILE    $True    limit=42x
        Log To Console    this is run 10 times
    END
限制WHILE循环迭代时间
    WHILE    $True    limit=3 seconds
        Log To Console    this is run 10 seconds
    END
# 当超过限制时，循环中的关键字不会被强制停止。循环的退出方式与条件变为假时相同。主要区别在于此时循环状态将为 FAIL。
限制WHILE循环迭代--on_limit自定义退出状态
    WHILE    $TRUE    limit=5 seconds    on_limit=pass
        Log To Console    自定义退出状态为pass
    END
限制WHILE循环迭代--on_limit_message自定义错误信息（默认情况为WHILE loop was aborted because it did not finish within the limit of 0.5 seconds. Use the 'limit' argument to increase or remove the limit if needed.）
    WHILE    $TRUE    limit=2 seconds    on_limit=fail    on_limit_message=自定义错误信息
        Log To Console    自定义退出状态为fail
    END
使用BREAK和CONTINUE进行循环控制
    ${text}    Set Variable    zero
    FOR    ${element}    IN    one    two    three
        IF    '${element}' == 'two'    BREAK
        ${text}    Set Variable    ${text}-${element}
    END
    Should Be Equal    ${text}    zero-one

    ${text}    Set Variable    zero
    FOR    ${element}    IN    one    two    three
        IF    '${element}' == 'two'    CONTINUE
        ${text}    Set Variable    ${text}-${element}
    END
    Should Be Equal    ${text}    zero-one-three