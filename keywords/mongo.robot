*** Settings ***

Library    MongoLibrary
Library    Collections
Variables    ../variables/global.py

*** Variables ***





*** Keywords ***
Inserir dados no banco

    Conectar Mongodb
    ...    ${host}
    ...    ${port}
    ...    ${user}
    ...    ${password}

    Selecionar Database
    ...    ${database}

    FOR    ${PRODUTO}    IN    @{PRODUTOS}
        Set To Dictionary
        ...    ${PRODUTO}
        ...    Data
        ...    ${agora}     

        ${id}=    Inserir Registro
        ...    ${PRODUTO} 
        ...    tabela_preços

        Log    ${id}   
    END    