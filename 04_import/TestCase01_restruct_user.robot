*** Settings ***
Library    ../.library/restruct_user.py
Variables    ../.library/restruct_user.py

*** Test Cases ***
# 将实例化对象操作内敛进成员方法，需要调用实例对象时，只需要调用返回实例对象的关键字即可
Case01
    ${keyword_return}    ReturnRestructUser
    Log To Console    ${keyword_return.name}