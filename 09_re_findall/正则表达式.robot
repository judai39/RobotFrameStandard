*** Settings ***

*** Test Cases ***
TestCase01
    [Documentation]    关于正则表达式的符号使用
    # \S+ 只匹配非空白字符，它会匹配到该行末尾。如果微码版本号后面还有其他内容（如括号中的说明），可能会匹配过多或不符合预期。
    ${res}    Set Variable    "CPU Microcode: Microcode Patch Level: 0x2b000041  Microcode Patch Level: 0x2b000042"    #"""${res}"""是因为res中的空格或者换行符，制表符等符号可能将res作为列表传入
    ${str1}    Evaluate    re.search(r'Microcode Patch Level: (\\S+)', """${res}""")[1].strip()    #re.search()[1]返回第一个捕获组的内容
    log    ${str1}    #0x2b000041
    ${str2}    Evaluate    re.search(r'Microcode Patch Level: (\\S+)', """${res}""")[0].strip()    #re.search()[0]返回整个匹配的内容
    log    ${str2}    #Microcode Patch Level: 0x2b000041

    # \s匹配空白字符，包括空格、制表符、换行符等。它会匹配到该行末尾的空白字符。如果微码版本号后面还有其他内容（如括号中的说明），可能会匹配过多或不符合预期。
    # \(匹配左括号，\)匹配右括号。它们用于匹配文本中的括号字符，而不是表示正则表达式中的分组。
    ${res1}    Evaluate    "This is Numa message : NUMA node(s):\t8;"
    ${str1}    Evaluate    re.search(r'NUMA node+\\(s\\):+\\s*4',"""${res1}""")[0].strip()
    log    ${str1}