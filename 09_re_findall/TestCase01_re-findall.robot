*** Settings ***

*** Test Cases ***
TestCase01
    [Documentation]    re.findall()方法的使用，将查找的文本内容以列表的形式返回
    ${text}    Set Variable    "SMBIOS 2.7 === SMBIOS 3.0 === SMBIOS 4.0 ==="
    ${pattern_贪婪}    Evaluate    re.findall(r'SMBIOS.*===',${text})
    ${pattern_非贪婪}    Evaluate    re.findall(r'SMBIOS.*?===',${text})
    # .匹配任意字符，*表示匹配前面的字符0次或多次，?表示非贪婪模式
    # 贪婪模式会尽可能多的匹配字符，而非贪婪模式会尽可能少的匹配字符
    Log    ${pattern_贪婪}
    Log    ${pattern_非贪婪}

TestCase02
    [Documentation]    re.search()方法的使用，将查找的文本内容以对象（字符串）的形式返回
    ${text}    Set Variable    "SMBIOS 2.7 === SMBIOS 3.0 === SMBIOS 4.0 ==="
    ${result}    Evaluate    re.search(r'SMBIOS.*?===',${text}).group()
    Log    ${result}