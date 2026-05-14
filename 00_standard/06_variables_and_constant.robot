*** Variables ***
${Var1}    测试123
${Var2}    123456

*** Test Cases ***
普通变量
    ${var}    Set Variable    1234
    Log To Console    ${VAR}    #变量声明大小不敏感
    ${m y_var}    Set Variable    5678
    Log To Console    ${MYVAR}    #变量声明时，空格和下划线会被省略

Scalar变量（$修饰）
    Log To Console    Var1 is ${Var1}
    Log To Console    Var2 is ${Var2}

    ${var1}    Set Variable    ${Var1}
    ${var2}=    Set Variable    ${Var2}

    Log To Console    var1 is ${var1}
    Log To Console    var2 is ${var2}
    # 当传递 Scalar 变量给关键字作为参数的时候， 就是直接把它所对应的 Python 对象类型传递给关键字对应的函数
    # 每个 List 变量和 Dict 变量，也是 Scalar 变量

List变量
    # 1、evaluate赋值python列表给变量
    ${list1}    evaluate    ['1',2,3,4]
    # 2、通过关键字创建一个列表变量
    ${list2}    create list    1    2    3    4    5
    # 3、通过@{list}声明一个列表变量（@修饰的变量为可变变量，相当于根据可变情况重新开辟内存，Scalar的list变量不是直接开辟内存，而是指向它传递而来的内存）
    # 指向由python代码而来的内存
    ${list3}    Evaluate    ['1',2,3,4]
    Log To Console    ${list3}
    # 指向由RF框架而来的内存
    ${list4}    Create List    1    2    3    4
    Log To Console    ${list4}

    # ${lists}可以看成是一个列表整体， @{lists} 可以看成整体拆成一个个单独的元素

    # Log To Console    @{list1}[0]
    # Log To Console    @{list2}[0]

    Log To Console    ${list1}[0]
    Log To Console    ${list2}[0]

    # 取倒数第一个
    # Log To Console    @{list1}[-1]
    # Log To Console    @{list2}[-1]

    Log To Console    ${list1}[-1]
    Log To Console    ${list2}[-1]

Dict变量
    # 1、evaluate赋值python字典给变量
    ${dict1}    Evaluate    {"name":"tom","age":19}
    # 2、通过关键字创建一个列表变量
    ${dict2}    Create Dictionary    name=tom    age=19
    # 3、声明一个列表变量，同@{list}
    &{dict3}    Evaluate    {"name":"tom","age":19}
    &{dict4}    Create Dictionary    name=tom    age=19

    Log To Console    ${dict1}
    Log To Console    ${dict2}
    Log To Console    ${dict3}
    Log To Console    ${dict4}
    # ${dict}可以看成是一个字典整体， &{dict} 可以看成整体拆成一个个${键值对}