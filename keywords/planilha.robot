*** Settings ***

Library     RPA.Excel.Files
Variables   ../variables/global.py

*** Variables ***


*** Keywords ***

Ler a planilha
    [Arguments]     ${CAMINHO_PLANILHA}

    Open Workbook       ${CAMINHO_PLANILHA}
    ${PRODUTOS} =       Read Worksheet As Table     header=True
    Close Workbook

    ${PRODUTOS} =           Convert To List    ${PRODUTOS}
    Set Suite Variable      ${PRODUTOS}
    Log Many                @{PRODUTOS}