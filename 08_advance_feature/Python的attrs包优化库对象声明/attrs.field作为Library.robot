*** Settings ***
Variables    ../../.library/SlotsParameters.py

*** Test Cases ***
访问attrs的类变量和实例变量
    Log To Console    SlotsParameters中的类变量${Student.name}，返回的不是地址，而是attrs实例对象<member 'name' of 'Student' objects>
    Log To Console    SlotsParameters中的实例变量${student_david.name}，${student_david.age}，${Student.classes}

# 不可用
# 访问slots参数的validator异常处理
#     TRY
#         Log To Console    ${validator_student}
#     EXCEPT    ValueError
#         ${validator_student.age}    Set Variable    1
#     FINALLY
#         Log To Console    异常捕获
#     END

访问attrs序列化实例对象
    Log To Console    ${dict_david}、${tuple_david}
