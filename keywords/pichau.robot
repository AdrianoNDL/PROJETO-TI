*** Settings ***

Library      SeleniumLibrary
Resource     common.robot
Variables    ../variables/global.py

*** Variables ***
${URL_PICHAU} =        https://www.pichau.com.br/
${TIMEOUT} =           10

# XPATHS
${ID_LOGOPICHAU} =           //h1//img[@alt="Pichau"]
${XPATH_ITEM_PICHAU} =       (//a[@data-cy="list-product"])[1]


*** Keywords ***

Acessar PC
    Set Selenium Timeout    ${TIMEOUT}
    Open Browser    ${URL_PICHAU}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=${ID_LOGOPICHAU}    


Encerrar navegação na PC
    Close Browser


Pesquisar e resgatar valor na PC
    [Arguments]     ${PRODUTO}
    
    ${STATUS} =     Run Keyword And Ignore Error
    ...     Pesquisar produto na PC   ${PRODUTO}

    IF  "${STATUS[0]}" == "PASS"
        Filtrar e selecionar o produto na PC
        Resgatar o valor na PC   ${PRODUTO}
    ELSE
        Registrar falta de produto na PC
    END


Pesquisar produto na PC
    [Arguments]     ${PRODUTO}

    Input Text    xpath=//input[@type="text"]    ${PRODUTO["Nome"]}
    Press Keys    xpath=//input[@type="text"]    ENTER
    Wait Until Element Is Visible    xpath=//small[text()="Produtos"]/parent::div/div


Filtrar e selecionar o produto na PC
    Scroll Element Into View    xpath=${XPATH_ITEM_PICHAU}
    Click Link    xpath=${XPATH_ITEM_PICHAU}
    Wait Until Element Is Visible    xpath=//button[@data-cy="add-to-cart"]


Resgatar o valor na PC
    [Arguments]     ${PRODUTO}

    ${FIRST_TRY} =    Run Keyword And Ignore Error
    ...    Get Text    (//span[text()="à vista"]/parent::div/div)[2]

    IF    "${FIRST_TRY[0]}" == "FAIL"
        ${VALOR} =    Get Text    xpath=//span[text()="à vista"]/parent::div/div
    ELSE
        ${VALOR} =    Set Variable    ${FIRST_TRY[1]}
    END
    
    Registrar valor de produto
    ...    ${PRODUTO}
    ...    PC
    ...    ${VALOR}

    Go To    ${URL_PICHAU}
    Wait Until Element Is Visible    xpath=${ID_LOGOPICHAU}


Registrar falta de produto na PC
    [Arguments]     ${PRODUTO}

    Registrar valor de produto
    ...    ${PRODUTO}
    ...    PC
    ...    R$ 0,00