# 1、@声明的的参数不是真正意义上的“列表”，&也是同理
# 在python代码中执行list($dictionary.keys())，返回的是该字典的键值组成的列表[key1,key2,....]
# 但是在robotframe中声明的&{dict},使用上述代码，返回的是一个odict_keys(['option1', 'option2'])，OrderedDict是字典的子类
*** Variables ***
&{dict}    key1=value1    key2=value2

*** Test Cases ***
Case01
    # ${key}    Evaluate    list(${dict.keys()})    报错，返回的odict_keys([。。。])无法转换成list
    ${key}    Evaluate    list(@{dict.keys()})    #可以通过编译
    # &{dict}不是字典，而是一个OrderDict(字典的子类)
    # @{list}不是列表，只是一堆有顺序的数字堆，可以使用list(@{list})转换成列表