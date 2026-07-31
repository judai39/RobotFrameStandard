*** Settings ***
Resource    ../.resource/resource.robot
Library    ../.library/User.py
Variables    ../.library/User.py



*** Test Cases ***
Case01
    # Resource资源只能调用关键字，声明时，class类名要和模块名一致，且不能有实例化类的逻辑，否则会被认为是Variables引入
    ${recieve_resource}    KeywordTest1

    # ${recieve_library_name}    Get User Name    #library/User.py中的实例化对象需要注释掉

    # Variable资源中，声明一个实例化对象以供调用，调用实例化对象可以直接使用${变量名.成员名}
    ${recieve_library_name}    Evaluate    $User.name
    ${recieve_instance_name}    Set Variable    ${User.name}
    Log To Console    ${recieve_instance_name}

Case02--evaluate语句快速导入对应python模块
    ${cpuinfo}    Set Variable    Microcode Patch Level: 0x1234
    # 在Evaluate语句后第二个参数为临时导入该语句的库（本例中为re）
    ${Microcode_version}    Evaluate    re.search(r'microcode\\S*: (\\S+)',${cpuinfo})[1].strip()    re

# φ(*￣0￣)：调用外部类中的实例化对象，类名和文件名要不一样，这和调用python类作为关键字的规则不一致，有什么办法可以统一呢？
