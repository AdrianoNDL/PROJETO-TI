*** Settings ***

Library     Collections

*** Keywords ***

Registrar valor de produto
    [Arguments]
    ...  ${PRODUTO}
    ...  ${LOJA}
    ...  ${VALOR}
    

    ${INDEX} =      Get Index From List
    ...  ${PRODUTOS}
    ...  ${PRODUTO}

    Set To Dictionary
    ...  ${PRODUTO}
    ...  Valor${LOJA}
    ...  ${VALOR}

    Set List Value
    ...  ${PRODUTOS}
    ...  ${INDEX}
    ...  ${PRODUTO}

    Set Suite Variable      ${PRODUTOS}