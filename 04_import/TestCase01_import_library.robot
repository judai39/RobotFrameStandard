*** Settings ***
Resource    ../.resource/resource.robot
# 调用外部python类作为关键字（类名和文件名要一致）
Library    ../.library/User.py
# ----如果希望调用外部python库中的一些实例化的离散对象(类名和文件名不能一样)
Variables    ../.library/User.py



*** Test Cases ***
Case01
    # Resource资源只能调用关键字，声明时，class类名要和模块名一致，且不能有实例化类的逻辑，否则会被认为是Variables引入
    ${recieve_resource}    KeywordTest1
    ${recieve_library_name}    Get User Name
    # Variables资源在类名模块名一致的情况下，需要在类中声明
    ${recieve_library_name}    Evaluate    User.User().name
    ${recieve_instance_name}    Set Variable    ${User.name}
    Log To Console    ${recieve_instance_name}

# φ(*￣0￣)：调用外部类中的实例化对象，类名和文件名要不一样，这和调用python类作为关键字的规则不一致，有什么办法可以统一呢？
