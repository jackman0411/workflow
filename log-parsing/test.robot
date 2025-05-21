# ==============================================================================
#  ASUSTeK Confidential
# ==============================================================================
#  Copyright 2025 The ASUSTeK Robot Engine Authors. All rights reserved.
# ==============================================================================

*** Settings ***
Resource  resources/common.resource

*** Test Cases ***
"Input Should Contain All Lines In File" Should Pass For Single Line File
   [Documentation]    Verifies the functionality of "Input Should Contain All Lines In
   ...                File" with a single line input.
   [Timeout]          1 min
   [Tags]             unit-test
   Input Should Contain All Lines In File    "robot"    ${CURDIR}/single-line.txt

"Input Should Contain All Lines In File" Should Fail For Single Line File
   [Documentation]    Verifies the functionality of "Input Should Contain All Lines In
   ...                File" with a failing test.
   [Timeout]          1 min
   [Tags]             unit-test
   Run Keyword And Expect Error  *  Input Should Contain All Lines In File    "javascript"    ${CURDIR}/single-line.txt

"Input Should Contain All Lines In File" Should Pass For Multi Line File
   [Documentation]    Verifies the functionality of "Input Should Contain All Lines In
   ...                File" with multiple lines as input.
   [Timeout]          1 min
   [Tags]             unit-test
   Input Should Contain All Lines In File    ["robot", "framework"]   ${CURDIR}/multiple-lines.txt

"Input Should Contain All Lines In File" Should Fail For Multi Line File
   [Documentation]    Verifies the functionality of "Input Should Contain All Lines In
   ...                File" with multiple lines as input failing.
   [Timeout]          1 min
   [Tags]             unit-test
   Run Keyword And Expect Error  *  Input Should Contain All Lines In File    ["robot"]   ${CURDIR}/multiple-lines.txt

"Input Should Contain Any Line In File" Should Pass For Multi Line File
   [Documentation]    Verifies the functionality of "Input Should Contain Any Line In
   ...                File" with multiple lines as input.
   [Timeout]          1 min
   [Tags]             unit-test
   Input Should Contain Any Line In File    ["robot"]   ${CURDIR}/multiple-lines.txt

"Input Should Contain Any Line In File" Should Fail For Multi Line File
   [Documentation]    Verifies the functionality of "Input Should Contain Any Line In
   ...                File" with multiple lines as input failing.
   [Timeout]          1 min
   [Tags]             unit-test
   Run Keyword And Expect Error  *  Input Should Contain Any Line In File    ["javascript"]   ${CURDIR}/multiple-lines.txt

"Lines In File A Should All Be In File B" Should Pass
   [Documentation]    Verifies the functionality of "Lines In File A Should All Be
   ...                In File B".
   [Timeout]          1 min
   [Tags]             unit-test
   Lines In File A Should All Be In File B    ${CURDIR}/short-file.txt   ${CURDIR}/long-file.txt

"Lines In File A Should All Be In File B" Should Fail
   [Documentation]    Verifies the functionality of "Lines In File A Should All Be
   ...                In File B failing".
   [Timeout]          1 min
   [Tags]             unit-test
   Run Keyword And Expect Error  *  Lines In File A Should All Be In File B    ${CURDIR}/long-file.txt   ${CURDIR}/short-file.txt

"File Should Contain" Should Pass
   [Documentation]    Verifies the functionality of "File Should Contain".
   [Timeout]          1 min
   [Tags]             unit-test
   File Should Contain    ${CURDIR}/short-file.txt    robot

"File Should Contain" Should Fail
   [Documentation]    Verifies the functionality of "File Should Contain"
   ...                failing.
   [Timeout]          1 min
   [Tags]             unit-test
   Run Keyword And Expect Error  *  File Should Contain    ${CURDIR}/short-file.txt    robotics
