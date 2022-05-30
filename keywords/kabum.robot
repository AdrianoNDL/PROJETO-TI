*** Settings ***

Library      SeleniumLibrary
Resource     common.robot
Variables    ../variables/global.py

*** Variables ***
${URL_KABUM} =        https://www.kabum.com.br/
${TIMEOUT} =          10

# XPATHS
${ID_LOGOKABUM} =    logoKabum
${XPATH_ITEM_KABUM} =      (//div[contains(@class, "productCard")])[1]//a


*** Keywords ***

Acessar KB
    Set Selenium Timeout    ${TIMEOUT}
    Open Browser    ${URL_KABUM}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    id=${ID_LOGOKABUM}


Encerrar navegação na KB
    Close Browser


Pesquisar e resgatar valor na KB
    [Arguments]     ${PRODUTO}
    
    ${STATUS} =     Run Keyword And Ignore Error
    ...     Pesquisar produto na KB   ${PRODUTO}

    IF  "${STATUS[0]}" == "PASS"
        Filtrar e selecionar o produto na KB
        Resgatar o valor na KB   ${PRODUTO}
    ELSE
        Registrar falta de produto na KB    ${PRODUTO}
    END


Pesquisar produto na KB
    [Arguments]     ${PRODUTO}

    Input Text    id=input-busca    ${PRODUTO["Nome"]}
    Click Button    xpath=//button[@type="submit" and not(@id)]
    Wait Until Element Is Visible    id=listingCount


Filtrar e selecionar o produto na KB
    Scroll Element Into View    xpath=${XPATH_ITEM_KABUM}
    Click Link    xpath=${XPATH_ITEM_KABUM}
    Wait Until Element Is Visible    xpath=//button[text()='COMPRAR']


Resgatar o valor na KB
    [Arguments]     ${PRODUTO}

    ${VALOR} =    Get Text    xpath=//h4[@itemprop='price']
    
    Registrar valor de produto
    ...    ${PRODUTO}
    ...    KB
    ...    ${VALOR}

    Go To    ${URL_KABUM}
    Wait Until Element Is Visible    id=${ID_LOGOKABUM}


Registrar falta de produto na KB
    [Arguments]     ${PRODUTO}

    Registrar valor de produto
    ...    ${PRODUTO}
    ...    KB
    ...    R$ 0,00