*** Settings ***
Library    ../.library/ZeroDivide.py

# Python 中的异常是对象，而 Robot Framework 中处理的是作为字符串的错误消息
*** Test Cases ***
使用EXCEPT模式匹配错误捕获异常（glob模式匹配，REGEXP正则表达式匹配，START只匹配错误开头）
# 注：模式匹配错误捕获的不是真正的异常对象，而是异常信息
# 1、GLOB模式匹配
    TRY
        DivisionByZeroKeyword
    EXCEPT    *[Dd]ivision ?? zero*    type=glob
        Log To Console    捕获到异常信息“ZeroDivisionError: division by zero”，[Dd]匹配不区分大小写，*匹配任意数量字符，?匹配任意单个字符
        ${result}=    Set Variable    0
    END
    Log To Console    计算结果为${result}
# 2、REGEXP正则表达式匹配
    TRY
        ${value}    Evaluate    int("abc")
    EXCEPT    .*ValueError.*    type=REGEXP    #.*匹配任意数量任意字符
        Log To Console    捕获到异常信息“ ValueError: invalid literal。。。”
    END
# 3、只匹配错误开头--有误
    TRY
        DivisionByZeroKeyWord
    EXCEPT    ZeroDivisionError    type=START
        Log To Console    捕获到异常信息“division by zero”
    END

使用ELSE，FINALLY
    TRY
        DivisionByZeroKeyword
    EXCEPT    *[Dd]ivision by zero*    type=glob
        Log To Console    捕获到异常信息“ZeroDivisionError: division by zero”
        ${result}=    Set Variable    0
    ELSE
        Log To Console    异常信息捕获成功后执行else语句，一个TRY只能由一个else分支
    FINALLY
        Log To Console    无论异常捕获与否都会执行finally语句
    END

使用RunKeywordAndExpectError关键字（BuiltIn.py库中方法）捕获异常
    ${error}=    RunKeywordAndExpectError    *    DivisionByZeroKeyword
    Should Contain    ${error}    division by zero
    Log To Console    捕获到异常：${error}
    ${result}    Set Variable    0
    Log To Console    计算结果为${result}

使用RunKeywordAndIgnoreError关键字（BuiltIn.py库中方法）忽视异常并返回状态元组(tuple[Literal['PASS', 'FAIL'], object])
    ${error}=    RunKeywordAndIgnoreError    DivisionByZeroKeyWord
    # ('FAIL', "Evaluating expression '2/0' failed: ZeroDivisionError: division by zero")
    Log To Console    ${error}


使用pyton库逻辑捕获处理后的值
    TRY
        ${result}=    DivideWithException    2    0
        # 由于捕获的是python库中的异常，是对象，所以可以用ZeroDivisionError异常类接收
    EXCEPT    ZeroDivisionError
        Log To Console    捕获到Python的ZeroDivisionError异常
        ${result}    Set Variable    0
    END
    Log To Console    计算结果为${result}
    # 捕获的是python库中处理异常后的数据0.0
    ${safe_result}=    Safe Divide    2    0



*** Keywords ***
DivisionByZeroKeyWord
    ${except_statement}    Evaluate    ${2}/${0}
ValueErrorKeyword
    ${value}    Evaluate    int("abc")