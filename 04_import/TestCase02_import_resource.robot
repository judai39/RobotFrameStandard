*** Settings ***
# 关于资源文件的后缀，最好为.resource
# Resource    ../.resource/resource.robot
# reStructuredText文件资源
Resource    ../.resource/reStructuredText_test.rst
Resource    ../.resource/resource.rsrc


*** Test Cases ***
Resource_rst
    Log To Console    ${message}
    My Keyword    ${CURDIR}

Resource_json
    # 先运行JsonToResourceFile.py文件将json数据转换成resource形式
    Log To Console    ${URL} file in resource.rsrc