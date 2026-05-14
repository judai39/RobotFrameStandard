*** Variables ***
&{DICT_SAMPLE}    a=ONE    b=TWO    c=THREE

*** Keywords ***
Keyword01
    [Arguments]    ${arg1}=1    ${arg2}=2
        ${sum}    Evaluate    ${arg1}+${arg2}
        Log To Console    ${sum}

*** Test Cases ***
字典迭代
    FOR    ${KEY}    ${VALUE}    IN    &{DICT_SAMPLE}
        Log To Console    KEY is ${KEY} AND VALUE IS ${VALUE}
    END

字典迭代与ENUMERATE（ENUMERATE默认读取第一个参数作为下标值进行赋值）
    FOR    ${index}    ${VALUE}    IN ENUMERATE    &{DICT_SAMPLE}
        Log To Console    下标为${index}，DICT_SAMPLE的key为${VALUE}[0]，DICT_SAMPLE的value为${VALUE}[1]
    END
@{字典}遍历key值
    FOR    ${KEY}    IN    @{DICT_SAMPLE}
        Log To Console    DICT_SAMPLE的key值为${KEY}
    END
循环变量转换
    FOR    ${VALUES: bytes}    IN    HELLO!    WORLD!    \x00\x00\x07
        Log    ${VALUES}    formatter=repr
        Log To Console    ${VALUES}
    END
重复执行关键字--Repeat Keyword（频繁使用for太麻烦）
    Repeat Keyword    5    Keyword01    2    3