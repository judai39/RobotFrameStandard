*** Settings ***
Library    MyObj.py    AS    my_obj

*** Variables ***
${STR}    hello,world


*** Test Cases ***
MyObject_TestCase
    ${OBJ}    my_obj.Get String
    Log To Console    接收到字符串${STR}
    Log To Console    接收到字符串${OBJ}
# 环境变量
Environment Variables
    Log To Console    Current User:%{USERNAME}
ListMember_TestCase
    ${list}=    Evaluate    [['a','b','c'],{'key':['x','y']}]
    Log Many    @{list}[0]
    Log Many    @{list}[1][key]
DictMember_TestCase
    ${dict}=    Evaluate    {"key1":"value1","key2":"value2"}
    Log To Console    ${dict}[key1]


