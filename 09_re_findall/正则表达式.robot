*** Settings ***

*** Test Cases ***
TestCase01
    [Documentation]    关于正则表达式的符号使用
    # \S+ 只匹配非空白字符，它会匹配到该行末尾。如果微码版本号后面还有其他内容（如括号中的说明），可能会匹配过多或不符合预期。
    ${res}    Set Variable    "CPU Microcode: Microcode Patch Level: 0x2b000041  Microcode Patch Level: 0x2b000042"
    ${str1}    Evaluate    re.search(r'Microcode Patch Level: (\\S+)', """${res}""")[1].strip()
    log    ${str1}