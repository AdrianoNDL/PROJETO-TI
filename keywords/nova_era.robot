*** Settings ***

Library      SeleniumLibrary
Resource     common.robot
Variables    ../variables/global.py

*** Variables ***
${URL_NOVA} =        https://lojanovaeragames.com.br/
${TIMEOUT} =         10

# XPATHS
${ID_LOGONOVA} =          (//article[@class="headerDesktop"]//img[@title="nova era games"])[1]
${XPATH_ITEM_NOVA} =      (//div[@class="produto"])[1]//a


*** Keywords ***

Acessar NE
    Set Selenium Timeout    ${TIMEOUT}
    Open Browser    ${URL_NOVA}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=${ID_LOGONOVA}


Encerrar navegação na NE
    Close Browser


Pesquisar e resgatar valor na NE
    [Arguments]     ${PRODUTO}
    
    ${STATUS} =     Run Keyword And Ignore Error
    ...     Pesquisar produto na NE   ${PRODUTO}

    IF  "${STATUS[0]}" == "PASS"
        Filtrar e selecionar o produto na NE
        Resgatar o valor na NE   ${PRODUTO}
    ELSE
        Registrar falta de produto na NE    ${PRODUTO}
    END


Pesquisar produto na NE
    [Arguments]     ${PRODUTO}

    Input Text    xpath=(//input[@id="_realizar_pesquisar"])[1]    ${PRODUTO["Nome"]}
    Click Button    xpath=(//button[@type="submit"])[1]
    Wait Until Element Is Visible    xpath=(//label[@for="usuario"])[1]
    ${RESULTADOS} =    Get Text    xpath=(//label[@for="usuario"])[1]

    IF    "${RESULTADOS}" == "0 Produtos encontrados"
        Fail
    END


Filtrar e selecionar o produto na NE
    Scroll Element Into View    xpath=${XPATH_ITEM_NOVA}
    Click Link    xpath=${XPATH_ITEM_NOVA}
    Wait Until Element Is Visible    id=comprar_agora


Resgatar o valor na NE
    [Arguments]     ${PRODUTO}

    ${FIRST_TRY} =    Run Keyword And Ignore Error
    ...    Get Text    id=vp

    IF    "${FIRST_TRY[0]}" == "FAIL"
        ${VALOR} =    Set Variable    R$ 0,00
    ELSE
        ${VALOR} =    Set Variable    ${FIRST_TRY[1]}
    END
    
    Registrar valor de produto
    ...    ${PRODUTO}
    ...    NE
    ...    ${VALOR}

    Go To    ${URL_NOVA}
    Wait Until Element Is Visible    xpath=${ID_LOGONOVA}


Registrar falta de produto na NE
    [Arguments]     ${PRODUTO}

    Registrar valor de produto
    ...    ${PRODUTO}
    ...    NE
    ...    R$ 0,00