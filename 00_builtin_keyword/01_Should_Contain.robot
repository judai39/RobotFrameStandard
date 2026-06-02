*** Variables ***
&{son_dict}    value1=1    value2=2    value3=3
&{dictionary1}    dict_value1=${son_dict}
&{dictionary2}    dict_value1=${son_dict}
&{dictionary3}    dict_value1=${son_dict}
*** Test Cases ***
case01
    FOR    ${option_iterator1}    ${option_iterator3}    ${option_iterator2}    IN ZIP    ${dictionary1}    ${dictionary2}    ${dictionary3}
        Log To Console    ${option_iterator1} and ${option_iterator2} and ${option_iterator3}
        # Should Contain参数为container，value，如果容器的成员为字典类型，在调用该字典成员时应使用“${parent_dict}\[son_dict]”
        # 如果容器的成员为列表类型，调用时应使用“${parent_list}[son_list]”
        Should Contain    ${option_iterator1}\[son_dict]    value1
    END