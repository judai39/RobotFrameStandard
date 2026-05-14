# 用户关键字标签

# 1、批量设置，在settings中设置Keywords Tags
*** Settings ***
# 在此位置声明标签的情况下，拥有此设置的文件的所有关键字都会获得标签
Keyword Tags    gui    html

*** Keywords ***
Own Tags
    [Documentation]    该关键字拥有gui、html、own、tags
    [Tags]    own    tags
    No Operation
Remove Tags
    [Documentation]    使用-tag name删除已有标签
    [Tags]    -html    own
    No Operation
Documentation Claim Tags
    [Documentation]    此外，还可以在Documentation标签的最后一行通过Tags:前缀指定关键字标签
    ...    Tags: my, fine ,tags
    No Operation