*** Settings ***
Library    ../.venv/Lib/site-packages/robot/libraries/Collections.py
*** Test Cases ***
简单FOR循环
    FOR    ${animal}    IN    cat    dog    bird    3    ${4}
        Log To Console    ${animal}
        FOR    ${element}    IN    嵌套for循环
            Log To Console    ${element}
        END
    END
多个FOR循环
    FOR    ${index}    ${english}    ${finish}    IN
    ...    1     CAT    KISSA
    ...    2    DOG    KOIRA
    ...    3    HORSE    HEVONEN
        Add Translation    ${english}    ${finish}    ${index}
    END
FOR-IN-RANGE循环（START END opt.STEPS--从START开始，每个循环增加opt.STEPS，直到END（开区间）为止）
    FOR    ${counter}    IN RANGE    13    -13    -7    #13、6、-1、-8
        Log To Console    ${counter}
    END
FOR-IN-ENUMERATE循环（start=<index>作为头部的最后一项指定自定义起始索引）
    FOR    ${index}    ${element}    IN ENUMERATE    zero    one    two    three    four    start=5
        Log To Console    ${index}: ${element}
    END
    # 嵌套多个循环
    FOR    ${index}    ${english}    ${finish}    IN ENUMERATE
    ...    cat    kissa
    ...    dog    koira
    ...    horse    hevonen
        Add Translation    ${english}    ${finish}    ${index}
    END
如果enumerate循环只使用一个循环变量，该变量会成为包含索引和迭代值的python元组【(0,zero),(1,one)...】
    FOR    ${x}    IN ENUMERATE    zero    onw    two    three
        Length Should Be    ${x}    2
        Log To Console    index is ${x}[0] and item is ${x}[1]
    END
# 有些测试会构建多个相关列表，然后一起遍历它们。    FOR-IN-ZIP（源自Python内置的zip()函数）
人为遍历多列表
    VAR    @{NUMBERS}    ${1}    ${2}    ${5}
    VAR    ${NAMES}    ONE    TWO    FIVE
    # 手动获取数组长度
    ${LENGTH}    Get Length    ${NUMBERS}
    # 手动调整数组长度与数组下标数字一致
    ${LENGTH}    Evaluate    ${LENGTH}-${1}
    FOR    ${INDEX}    IN    ${LENGTH}
        Log Many    ${NUMBERS}[${INDEX}]    ${NAMES}[${INDEX}]
    END
FOR-IN-ZIP循环，自动构建多个相关列表并遍历
    @{NUMBERS}=    Create List    ${1}    ${2}    ${5}
    @{NAMES}=    Create List    ONE    TWO    FIVE
    @{LISTS}    Set Variable    ${NUMBERS}    ${NAMES}
    FOR    ${NUMBERS_ITEMS}    ${NAMES_ITEMS}    IN ZIP    @{LISTS}
        # 使用log to console输出信息时传入第二个参数时stream注意制表符的使用
        Log Many    ${NUMBERS_ITEMS}-${NAMES_ITEMS}
    END
# 和ENUMERATE循环一样，如果只使用单个参数接收，会成为包含索引和迭代值的元组
FOR-IN-ZIP循环，只使用单个参数接收
    VAR    @{NUMBERS}    ${1}    ${2}    ${5}
    VAR    @{NAMES}    ONE    TWO    FIVE
    VAR    @{LISTS}    ${NUMBERS}    ${NAMES}
    FOR    ${TUMPLE_INDEX}    IN ZIP    @{LISTS}
        Log To Console    ${TUMPLE_INDEX}[0] and ${TUMPLE_INDEX}[1]
    END
# FOR-IN-ZIP循环，迭代模式处理（当多列表参数数量不等时）
Strict mode模式（数量不同直接报错）
    VAR    @{CHARACTERS}     a    b    c    d    f
    VAR    @{NUMBERS}        1    2    3
    FOR    ${INDEX1}    ${INDEX2}    IN ZIP    ${CHARACTERS}    ${NUMBERS}    mode=Strict
        Log To Console    ${INDEX1} - ${INDEX2}
    END
Short mode模式（遍历次数取决于较少的）
    VAR    @{CHARACTERS}     a    b    c    d    f
    VAR    @{NUMBERS}        1    2    3
    FOR    ${INDEX1}    ${INDEX2}    IN ZIP    ${CHARACTERS}    ${NUMBERS}    mode=SHORTEST
        Log To Console    ${INDEX1} - ${INDEX2}
    END
LONGEST mode模式（遍历次数取决于较多的，空缺值自动使用NONE填充，参数fill将会决定自动填充的数）
    VAR    @{CHARACTERS}     a    b    c    d    f
    VAR    @{NUMBERS}        1    2    3
    FOR    ${INDEX1}    ${INDEX2}    IN ZIP    ${CHARACTERS}    ${NUMBERS}    mode=LONGEST    fill=1
        Log To Console    ${INDEX1} - ${INDEX2}
    END

    



*** Keywords ***
Add Translation
    [Arguments]    ${english}    ${finish}    ${index}
    Log To Console    ${english}位于${finish}的第${index}个