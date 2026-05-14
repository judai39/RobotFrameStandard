Resource file using reStructuredText
------------------------------------

This text is outside code blocks and thus ignored.

.. code:: robotframework

   *** Settings ***
   Library          OperatingSystem

   *** Variables ***
   ${MESSAGE}       Hello, world!

Also this text is outside code blocks and ignored. Code blocks not
containing Robot Framework data are ignored as well.

.. code:: robotframework

   # Both space and pipe separated formats are supported.

   | *** Keywords ***  |                        |         |
   | My Keyword        | [Arguments]            | ${path} |
   |                   | Directory Should Exist | ${path} |