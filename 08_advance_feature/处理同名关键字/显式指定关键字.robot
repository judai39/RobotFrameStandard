*** Settings ***
# Resource    ../../.resource/test_resource.robot
Library    ../../.library/TestLibrary.py
Library    ../../.library/TestLibraryNew.py

*** Test Cases ***
Case01
    # 1、需要指定不符合默认调用顺序的keyword时，需要处理冲突
    #     -->调用Keyword指定路径前缀
    # 我们希望调用Resource文件中的Should Be Equal方法
    # test_resource.Should Be Equal    ${1}    ${2}
    # 调用Library库中的Should Be Equal方法
    TestLibrary.Should Be Equal    ${1}    ${2}

    # 2、如果库文件中有很多的关键字方法需要调用，总不能每个关键字调用处都加上路径前缀吧。。。
    # 使用Set Library Search Order关键字，该关键字接收一个有序的库列表作为参数，当关键字发生冲突时，会优先使用该列表中的第一个带有关键字的文件
    # 虽然该关键字名称中包含 library 一词，但它同样适用于资源文件。不过如前所述，资源中的关键字始终比库中的关键字具有更高的优先级。
    Set Library Search Order    TestLibraryNew    TestLibrary
    ${result}    Should Be Equal    ${1}    ${2}
    Log To Console    ${result}
