*** Test Cases ***
# 0、必须遍历可变参数@{}对象
# RangeForExample1
#     ${list}    Evaluate    [1,2,3,4,5]
#     FOR    ${item}    IN    ${list}    这样只会让${item}指向${list}
#         Log    ${item}
#     END

# 1、一个简单的for循环
RangeForExample
    FOR    ${item}    IN RANGE    1    11
    # 在逻辑语句中，局部变量可以使用$item的形式引用
        Log    $item
    END


# 2、使用enumerate()函数遍历列表，追踪每个元素的索引位置
EnumerateWithForExample
    ${list}    Evaluate    [1,2,3,4,5]
    # FOR    ${index}    ${item}    IN ENUMERATE    ${list}    这样声明FOR循环，会将[1,2,3,4,5]整个list对象交给循环进行遍历，结果就是0，[1,2,3,4,5]
    FOR    ${index}    ${item}    IN ENUMERATE    @{list}
        Log Many    ${index}    ${item}
    END

# 3、遍历Dict变量
基础遍历Dict
    &{DICT}    Create Dictionary    a=1    b=2    c=3
    FOR    ${key}    ${value}    IN    &{DICT}
        Log To Console    Key is ${key} and value is ${value}
    END
遍历Dict并通过Enumerate返回索引
    &{DICT}    Create Dictionary    a=1    b=2    c=3
    FOR    ${index}    ${key}    ${value}    IN ENUMERATE    &{DICT}
        Log To Console    On round ${index} , Key is ${key} and value is ${value}
    END
遍历多个Dict
    &{DICT1}    Create Dictionary    a=1    b=2    c=3
    &{DICT2}    Create Dictionary    a=4    b=5    c=6
    &{DICT3}    Create Dictionary    d=4    e=5    f=6
    FOR    ${key}    ${value}    IN    &{DICT1}    &{DICT2}    &{DICT3}
        Log To Console    Key is ${key} and value is ${value}    #DICT1的内容不会被输出，如果多个Dict作为参数进行遍历，会被优化成一整个包含所有Dict元素的大Dict，此时，如果元素集中有重复key，则会被覆盖
    END

用list接收Dict值
    &{DICT}    Create Dictionary    a=1    b=2    c=3
    FOR    ${item}    IN    &{DICT}
        Log To Console    Key is ${item}[0] and value is ${item}[1]
    END

退出循环
    @{list}    Create List    1    2    3    4    5
    FOR    ${item}    IN    @{list}
        Log To Console    ${item}
        Exit For Loop If    ${item}==3
    END