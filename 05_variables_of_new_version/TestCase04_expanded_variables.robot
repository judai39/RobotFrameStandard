*** Settings ***
Variables    MyObject.py
Variables    user.py

*** Test Cases ***
MyObject_TestCase
    # python代码创建实例化对象
    ${attr1}    Evaluate    MyObject.MyObject('Robot')
    Log To Console    ${attr1}
    ${attr2}    Evaluate    MyObject.OBJECT
    Log To Console    ${attr2}
    ${eat_result}    Evaluate    MyObject.OBJECT.eat("apple")
    # 注意：不能使用${attr2}.eat("apple")，此时的${attr2}已经是OBJECT实例对象调用__str__方法，返回的是字符串，已经不是对象了
    # φ(*￣0￣)：RF框架中的变量都是一个确定的数据，不存在抽象的类的实例化对象来进行数据的储存
    ${name}=    Set Variable    ${OBJECT.name}
    # !!!!!!!!OBJECT不存在？？？？？
    # MyObject.py的命名空间的问题，如果文件名MyObject与其中的类名一致，RF框架在命名空间中寻找对应的变量实例存放在Variables节中，但是由于类名和文件名（模块名）一致，RF会错误识别类为实例对象，但是类不是实例对象，所以会报错“Variable '${USER}' not found”

MyObject_TestCase_Upgrade
    # 将类名改为User后
    # python类名调用，rf将其类型转换为${attr1}字符串
    ${attr1}    Evaluate    user.USER.name
    # 使用RF拓展变量方式访问实例化对象的成员信息
    ${name}=    Set Variable    ${USER.name}
    Should Be Equal    ${name}    John

    
    
String_TestCase
    ${string}    Evaluate    str(abc)
    # 使用VAR    ${string}    str(abc)也能运行成功，但是下面的${string.upper()}无法通过编译，这是因为Evaluate指向的是python类中的那个引用对象，而使用VAR或者SET VARIABLE都是直接将右侧的值传递给左侧

    # 调用RF框架中默认变量类型string的类方法upper()
    Log To Console    ${string.upper()}
    Log To Console    ${string * 2}
Number_TestCase
    # 同上，使用VAR能执行成功，但是下面的表达式无法通过编译
    VAR    ${number}    ${-2}
    Log To Console    ${number * 10}
    Log To Console    ${number.__abs__()}