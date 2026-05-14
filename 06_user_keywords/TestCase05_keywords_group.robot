# GROUP允许将相关关键字和控制结构组合在一起
# 和使用关键字嵌套调用的区别？
#     -->GROUP将所有由它管理的变量共享一个变量命名空间，不需要使用参数，返回值传递值
#     -->和直接在TestCase中调用差不多，使用GROUP可以让代码更直观
*** Test Cases ***
GroupCase01
    ${num_value}    Set Variable    ${0}
    GROUP    可以命名
        Keyword01    ${num_value}
        Keyword02    ${num_value}
        Keyword03    ${num_value}
    END
    Log To Console    ${num_value}


*** Keywords ***
Keyword01
    [Arguments]    ${num}
    ${_num}    Evaluate    ${num}+1
    Log To Console    ${_num}

Keyword02
    [Arguments]    ${num}
    ${_num}    Evaluate    ${num}+1
    Log To Console    ${_num}

Keyword03
    [Arguments]    ${num}
    ${_num}    Evaluate    ${num}+1
    Log To Console    ${_num}