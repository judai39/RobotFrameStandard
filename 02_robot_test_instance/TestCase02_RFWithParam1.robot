*** Settings ***
Library    OperatingSystem
*** Test Cases ***
CTEATE FILE CASE
    Create File    ${TEMPDIR}/empty.txt
    Create File    ${TEMPDIR}/utf8.txt    this is text content
    Create File    ${TEMPDIR}/iso8859.txt    this is text content    ISO-8859-1

# 1.可变数量的参数
REMOVE FILE CASE
    Remove Files    ${TEMPDIR}/empty.txt    ${TEMPDIR}/utf8.txt    ${TEMPDIR}/iso8859.txt
    @{paths}=    Join Paths    ${TEMPDIR}    empty.txt    utf8.txt    iso8859.txt

*** Variables ***
${TEMPDIR}    C:/Users/dkf11651/Desktop/RFProject/temp