*** Variables ***
${${NAME}}    使用VAR定义列表占位用

# 用户关键字参数
*** Keywords ***
位置参数
    [Arguments]    ${arg_name}
    Log To Console    Got argument${arg_name}

带默认值的参数
    [Arguments]    ${arg_name}="name"
    Log To Console    ${arg_name}

可变数量的参数--命名参数必须放在所有位置参数之后
# Robot Framework的参数解析遵循简单规则：
# 从左到右扫描参数
# 遇到位置参数 → 按顺序分配给未指定的形参
# 遇到命名参数 → 直接分配给指定名称的形参
# 一旦遇到命名参数，后续所有参数都必须是命名参数
    [Arguments]    ${req}    ${opt}=42    @{others}
    Log    Required: ${req}
    Log    Optional: ${opt}
    Log    Others:
    FOR    ${item}    IN    @{others}
        Log    ${item}
    END

自由命名参数-将会接收不匹配位置参数（或仅限命名参数）的命名参数
    [Arguments]    ${req}    ${opt}=42    &{named}
    Log Many    ${req},${opt},&{named}

仅限命名参数-普通参数放在可变数量参数之后
    [Arguments]    @{varargs}    ${named only}
    # 也可以使用[Arguments]    @{}    ${first}    ${second}    表示后续参数为仅限命名参数
    Log Many    @{varargs}    ${named only}
仅限命名参数-可以与位置参数和自由命名参数一起使用
    [Arguments]    ${value1}    ${value2}    ${named only}    &{free named}
    Log Many    ${value1}    ${value2}    ${named only}    &{free named}





*** Test Cases ***
Case03
    可变数量的参数--命名参数必须放在所有位置参数之后    1    2    3    4
    VAR    @{other_num}    one    two
    Log To Console    ${other_num}
    # 规则上，命名参数必须放在所有位置参数之后，在声明命名参数opt后，后面所有的参数都应该是命名参数
    可变数量的参数--命名参数必须放在所有位置参数之后    2    opt=3    @{other_num}    #报错   

Case04
    VAR    @{other_num}    one    two
    Log To Console    ${other_num}
    # 像Case03中的@{other_num}，无法确认这些参数的位置，就可以使用自由命名参数来接受（毕竟本质是字典，相当于在参数末尾放了一个字典的壳子，让字典用“命名参数”的规则接收这些参数）
    自由命名参数-将会接收不匹配位置参数（或仅限命名参数）的命名参数    1    opt=3    namded=${other_num}    #1,3,{'namded': ['one', 'two']}

Case05
    仅限命名参数-普通参数放在可变数量参数之后    1    2    3    named only=这是只能使用命名参数传入的参数
    仅限命名参数-可以与位置参数和自由命名参数一起使用    1    2    named only=这是只能使用命名参数传入的参数    free value1=3    free value2=4