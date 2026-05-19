*** Settings ***
Library                      SeleniumLibrary
Library                      BuiltIn
Library                      ../Resources/yaml_vars.py
Resource                     ../robotconfig.robot
Resource                     ../CommonActions/browserActions.robot

Test Setup                   Open Test Browser
Test Teardown                Close Test Browser


*** Test Cases ***

TC01 Launch Browser 
    Sleep    10s
    Log To Console    Browser Launched. 