*** Settings ***

Resource    ./keywords/planilha.robot
Resource    ./keywords/casas_bahia.robot

*** Tasks ***

Resgatar produtos para busca
    Ler a planilha      Produtos.xlsx

Realizar busca na Casas Bahia
    Acessar CB
    FOR   ${PRODUTO}   IN   @{PRODUTOS}
        Pesquisar e resgatar valor na CB    ${PRODUTO}
    END
    Encerrar navegação na CB
    Log Many    @{PRODUTOS}

#Realizar busca no Magazine Luiza

#Realizar busca no Ponto Frio

#Inserir preços no banco de dados