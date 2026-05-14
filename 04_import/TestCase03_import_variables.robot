*** Settings ***
# Variables    ../.library/user.py
# 也可以使用模块名导入(复杂路径下可能会报错，命令行指定库文件--variablefile不会报错，尽量不要使用)
# Variables    module.User
Variables    module/User.py
# 也可以使用命令行导入，见000_AAATestSuite
Library    ../.venv/Lib/site-packages/robot/libraries/Collections.py

*** Test Cases ***
CASE01
    Log To Console    module.user中的变量${VARIABLE}
    Log To Console    USER模块内的实例化对象${User}
    Log To Console    USER模块内的实例化对象${user}
    Log To Console    USER模块中的LIST__、DICT__前缀不会被识别:${ANIMALS}、${FINISH}
    ${instance}    Set Variable    ${User.name}
    Log To Console    ${instance}
    ${variables_dict}    Set Variable    ${User.variables}
    Log To Console    也可以在类属性、实例属性中创建变量供RF调用${user.age}、${user._not_variable}、${user.age}