*** Settings ***
Library    SeleniumLibrary
Resource    ../robotconfig.robot

*** Variables ***
${YAML_FILE}    ${CURDIR}/../Resource/test_data.yaml

*** Keywords ***
Open Test Browser
    # 1. Initialize Browser Options
    IF    '${BROWSER}' == 'Chrome'  

    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    
    # 2. Set Experimental Options (Preferences)
    # This specifically targets local network access settings
    ${prefs}=    Create Dictionary    profile.content_settings.exceptions.local_network_access.*.setting=${1}
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs}

    # 3. Add Arguments for Stability and Headless Mode
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    Call Method    ${chrome_options}    add_argument    --ignore-ssl-errors
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --disable-software-rasterizer
    Call Method    ${chrome_options}    add_argument    --window-size\=1920,1080

    # 4. Create the Webdriver instance
    Create Webdriver    Chrome    options=${chrome_options}
    SeleniumLibrary.Go To    ${LOGIN_URL}
    Maximize Browser Window
    Set Selenium Timeout    10 seconds

    ELSE IF    '${BROWSER}' == 'Edge'  

    ${edge_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    
    # 2. Set Experimental Options (Preferences)
    # This specifically targets local network access settings
    ${prefs}=    Create Dictionary    profile.content_settings.exceptions.local_network_access.*.setting=${1}
    Call Method    ${edge_options}    add_experimental_option    prefs    ${prefs}

    # 3. Add Arguments for Stability and Headless Mode
    Call Method    ${edge_options}    add_argument    --ignore-certificate-errors
    Call Method    ${edge_options}    add_argument    --ignore-ssl-errors
 #   Call Method    ${edge_options}    add_argument    --headless
    Call Method    ${edge_options}    add_argument    --no-sandbox
    Call Method    ${edge_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${edge_options}    add_argument    --disable-gpu
    Call Method    ${edge_options}    add_argument    --disable-software-rasterizer
    Call Method    ${edge_options}    add_argument    --window-size=1920,1080

    # 4. Create the Webdriver instance
    Create Webdriver    Chrome    options=${edge_options}
    SeleniumLibrary.Go To    ${LOGIN_URL}
    Maximize Browser Window
    Set Selenium Timeout    10 seconds
    END


Close Test Browser
    [Documentation]    Closes The Browser
    SeleniumLibrary.Close Browser