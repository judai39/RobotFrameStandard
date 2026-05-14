reStructuredText example
------------------------

code 块之外的文字会被忽略。

.. code:: robotframework

   *** Settings ***
   Documentation    Example using the reStructuredText format.
   Library          OperatingSystem

   *** Variables ***
   ${MESSAGE}       Hello, world!

   *** Test Cases ***
   My Test
       [Documentation]    Example test.
       Log    ${MESSAGE}
       My Keyword    ${CURDIR}

   Another Test
       Should Be Equal    ${MESSAGE}    Hello, world!

此段文本同样位于代码块之外，将被忽略。不包含 Robot Framework 数据的代码块也会被忽略。

.. code:: robotframework

   # Both space and pipe separated formats are supported.

   | *** Keywords ***  |                        |         |
   | My Keyword        | [Arguments]            | ${path} |
   |                   | Directory Should Exist | ${path} |

.. code:: python

   # This code block is ignored.
   def example():
       print('Hello, world!')