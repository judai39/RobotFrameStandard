*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    http://www.baidu.com
${BROWSER}    Edge

*** Keywords ***
Open Login Page    
    [Arguments]    ${param1}=${URL}    ${param2}=${BROWSER}
    Open Browser    ${param1}    ${param2}
    Title Should Be    login page
KeywordTest1
    [Arguments]    ${param1}=""    ${param2}=""
    Log To Console    ${param1}and${param2}