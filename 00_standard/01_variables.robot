*** Settings ***
# 2、settings调用其他python文件中的变量文件
Variables    C:/Users/dkf11651/Desktop/RFProject/parameter.py    #../parameter.py也可
Library    OperatingSystem
#1、Variables中创建变量
*** Variables ***
${my_url}    http://localhost/login/login.html


*** Test Cases ***
Test Case1
    # 3、直接${}创建变量
    Should Be Equal    ${my_url}    ${login_url}
    Log To Console    ${database}

# 4、着重看${}、@{}、&{}三者的区别
基础遍历Dict--使用$修饰DICT--error
    ${DICT}    Create Dictionary    a=1    b=2    c=3
    FOR    ${key}    ${value}    IN    ${DICT}
    # Number of FOR loop values should be multiple of its variables. Got 2 variables but 1 value.
    # 给出两个变量，但是只使用一个值接收，只使用{a=1,b=2,c=3}接收
    # 这意味着，${variables}指向变量最外层的地址
        Log To Console    Key is ${key} and value is ${value}
    END
基础遍历Dict--使用@修饰DICT--error
    ${DICT}    Create Dictionary    a=1    b=2    c=3
    FOR    ${key}    ${value}    IN    @{DICT}
    # Number of FOR loop values should be multiple of its variables. Got 2 variables but 3 values.
    # 给出两个变量，但是使用了三个值接收，使用了a(1),b(2),c(3)三个值进行接收
    # 这意味着，@{variables}指向多个变量
        Log To Console    Key is ${key} and value is ${value}
    END
    # 使用单个值接收
    FOR    ${item}    IN    @{DICT}
        Log To Console    ${item}    #a,b,c
    END
基础遍历Dict--使用&修饰DICT
    ${DICT}    Create Dictionary    a=1    b=2    c=3
    # 一般在取dict键值对时需要使用&{}
    FOR    ${key}    ${value}    IN    &{DICT}
        Log To Console    Key is ${key} and value is ${value}
    END