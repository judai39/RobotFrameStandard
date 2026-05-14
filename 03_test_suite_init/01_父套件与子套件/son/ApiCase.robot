*** Settings ***
Documentation    测试变量访问


*** Test Cases ***
Test Variable Access
    [Documentation]    测试访问__init__.robot中的变量
    Log    SUITE_VAR的值是: ${SUITE_VAR}
    Log    ANOTHER_VAR的值是: ${ANOTHER_VAR}
    
    # 访问列表变量
    @{list}=    Create List    ${LIST_VAR}
    Log    List第一个元素: @{list}[0]
    

Test Variable Scope Debug
    [Documentation]    调试变量作用域
    Log Variables    level=INFO    # 查看所有可用变量