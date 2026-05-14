*** Settings ***
Library    ../.venv/Lib/site-packages/robot/libraries/Process.py
Library    ../.venv/Lib/site-packages/robot/libraries/Easter.py
# 1、用户关键字支持基于显示指定类型的自动参数转换
*** Test Cases ***
Move around
    Move    3
    Turn    LEFT
    Move    2.3    log=True
    Turn    right

Failing move
    Move    bad

Failing turn
    Turn    oops

Select animal from list Case
    ${animal}    Create List    cat    dog    sheep
    Select ${animal} from list
    Select ${animal} from list with [argument]    david

Conditional Return Case
    ${ReturnArg}    Conditional Return    1
    Log To Console    ${ReturnArg}

FindIndex Case
    ${list}    Create List    1    2    3    
    ${ReturnNum}    Find Index    3    ${list}
    Log To Console    ${ReturnNum}



*** Keywords ***
Move
    [Arguments]    ${distance: float | int}    ${log: bool}=False    #float | int联合类型，自动映射float或int类型参数到distance作用域上
    IF    ${log}
        Log    Moving ${distance} meters.
    END

Turn
    [Arguments]    ${direction: Literal["LEFT", "RIGHT"]}    #Literal[1,2,3...]   Literable可遍历类型约束
    Log    Turning ${direction: Literal["LEFT", "RIGHT"]}.

# 2、将参数嵌入关键字名称（内嵌的变量在调用关键字时，不用使用制表符）
Select ${animal} from list    #使用Select ${1} from list调用关键字
    FOR    ${item}    IN    @{animal}
        Log To Console    ${item}
    END
# 2.1、RF6.1后，还可以将[Argument]和关键字名称参数一起使用
Select ${animal} from list with [argument]
    [Arguments]    ${hoster}='hoster'
    FOR    ${item}    IN    @{animal}
        Log To Console    ${hoster} host ${item}
    END

# 2.2、嵌入式参数匹配错误值
Select ${city} ${team}
    Log To Console    Selected ${city} ${team}
    # 假设用例调用关键字语句为 Select Los Angeles Lakers，匹配参数可能会把Los匹配成city导致错误，可以将参数使用双引号修饰
Select "${city}" "${team}"
    Log To Console    Selected ${city} ${team}

# 2.3、解决冲突
Execute "${cmd}"
    Run Process    ${cmd}    shell=${True}
    # Execute "lls" with "-lh" 可能也会匹配该关键字
    # 虽然RF框架会自动选择最适合的关键字，可能会正确选择下面关键字，保不齐以后会出错
Execute "${cmd}" with "${opts}"
    Run Process    ${cmd} ${opts}    shell=${True}
    # Execute "lls" with "-lh" 正常匹配关键字
Execute "lls"
    # 只需要在关键字中重新声明一个带有参数的关键字为No Operation即可解决冲突
    No Operation

# 2.4、使用正则表达式传入参数
Select ${city} ${team:\S+}    #"\S"匹配任意非空字符    "+"匹配前面的模式一次或多次
    Log To Console    Selected ${team} from ${city}
${number1:\d+} ${operator:[+-]} ${number2:\d+} = ${expected:\d+}    #"\d"匹配任意整数    [+-]匹配加号或减号    
    ${result} =    Evaluate    ${number1} ${operator} ${number2}
    Should Be Equal As Integers    ${result}    ${expected}
Deadline is ${deadline: date:\d{4}-\d{2}-\d{2}|today}    #"\d{4}"匹配任意整数四次    date:\d{4}-\d{2}-\d{2}|today    匹配具体日期或者今天日期
    Log    Deadline is ${deadline.day}.${deadline.month}.${deadline.year}.
Select ${animal:(?i)cat|dog}    #"(?...)"匹配正则表达式中的内敛标志语法    "i"：ignore case标志，使匹配不区分大小写
    [Documentation]    内联标志 `(?i)` 使模式不区分大小写。
    Log    Selected ${animal}!



# 3、使用Return语句
Conditional Return
    [Arguments]    ${args}
    IF    ${args}==1
        RETURN    #return的为None值
    END
Find Index
    [Arguments]    ${test}    ${items}
    [Documentation]
    FOR    ${index}    ${item}    IN ENUMERATE    @{items}
        IF    $item == $test    RETURN    ${index}
    END
    RETURN    ${-1}


# 4、用户关键字的setup和teardown
# 用户关键字可以像测试一样拥有 setup 和 teardown，与测试不同的是，无法为某个文件中的所有关键字指定公共的 setup 或 teardown。
Setup and teardown
    [Setup]    Log To Console    NEW IN RF 7!
    Log To Console    用户关键字可以像测试一样拥有 setup 和 teardown
    [Teardown]    Log To Console    Old feature


# 5、私有用户关键字
Pubilic Keywords
    # 和私有变量不同，其他关键字可以调用私有关键字只是会发出警告
    Private Keyword

Private Keyword
    # 通过添加robot:private标签实现私有关键字
    [Tags]    robot:private
    No Operation

# 6、递归
# 用户关键字可以直接或间接地调用自身。这种递归使用是允许的，只要递归在超过递归限制之前终止（通常基于某个条件）。该限制的存在是为了防止无限递归导致执行崩溃。

# Robot Framework 的递归检测机制会检查当前递归层级是否接近底层 Python 进程的递归限制。如果足够接近，将不允许启动新的关键字或控制结构，执行将失败。

# Python 的默认递归限制为 1000 个栈帧，实际上这意味着大约可以启动 140 个关键字或控制结构。如果不够用，可以通过 sys.setrecursionlimit() 函数提高 Python 的递归限制。正如该函数的文档所说，应谨慎操作，因为过高的限制可能导致崩溃。

# 在 Robot Framework 7.2 之前，递归限制硬编码为 100 个启动的关键字或控制结构。