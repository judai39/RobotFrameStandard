*** Variables ***
&{options}    CPU CE Threshold=${{1}}
...           APEI EINJ CPU CE Support=${1}

*** Test Cases ***
CASE01
    Log To Console    ${options}
    ${type1}    Evaluate    type(${options}[CPU CE Threshold])
    ${type2}    Evaluate    type(${options}[APEI EINJ CPU CE Support])
    Log To Console    ${type1} and ${type2}