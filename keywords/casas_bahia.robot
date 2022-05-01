*** Settings ***

Library         SeleniumLibrary
Resource        common.robot
Variables       ../variables/global.py

*** Variables ***
${URL} =             https://www.casasbahia.com.br/
${TIMEOUT} =         10
${ITEM} =            ((//ul[@data-cy="ul"]/li)[1]//a)[1]
${LOJA} =            CB

*** Keywords ***

Acessar CB
    Set Selenium Implicit Wait    ${TIMEOUT}
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    id=Logo


Pesquisar e resgatar valor na CB
    [Arguments]     ${PRODUTO}
    
    ${STATUS} =     Run Keyword And Ignore Error
    ...     Pesquisar produto na CB   ${PRODUTO}

    IF  "${STATUS[0]}" == "PASS"
        Filtrar e selecionar o produto na CB
        Resgatar o valor na CB   ${PRODUTO}
    ELSE
        Registrar falta de produto na CB
    END


Pesquisar produto na CB
    [Arguments]     ${PRODUTO}

    Input Text
    ...   id=strBusca
    ...   ${PRODUTO["Nome"]}
    Click Button    id=btnOK
    Wait Until Element Is Visible    xpath=//section//p[@data-cy="searchCount"]


Filtrar e selecionar o produto na CB
    Scroll Element Into View    xpath=${ITEM}
    Click Element    xpath=${ITEM}
    Wait Until Element Is Visible    xpath=buy-button


Resgatar o valor na CB
    [Arguments]     ${PRODUTO}
    
    ${VALOR} =    Get Text    id=product-price

    Registrar valor de produto
    ...  ${PRODUTO}
    ...  CB
    ...  ${VALOR}

    Go To   ${URL}
    Wait Until Element Is Visible    id=Logo


Encerrar navegação na CB
    Close Browser


Registrar falta de produto na CB
    Registrar valor de produto
    ...  ${PRODUTO}
    ...  CB
    ...  0,00

    Scroll Element Into View    id=Logo
    Go To   ${URL}
    Wait Until Element Is Visible    id=Logo