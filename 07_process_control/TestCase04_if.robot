*** Variables ***


*** Keywords ***
Keyword01
    [Arguments]    ${arg}=0
    Log To Console    this is keyword01's param arg \= ${arg}
Keyword02
    Log To Console    this is keyword02
Keyword of 内敛IF
    IF    ${true}    Keyword01    10
    IF    ${false}    Keyword01
    # 内敛同时也支持ELSE和ELSE IF分支
    IF    $false    Keyword01    ELSE IF    $True    Keyword02


*** Test Cases ***
内敛IF--对多个IF CONDITION语句进行的重构
    Keyword of 内敛IF
    
