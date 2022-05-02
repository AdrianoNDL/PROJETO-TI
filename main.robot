*** Settings ***

Resource    ./resources/precos.robot

*** Tasks ***

Resgatar produtos para busca
    Ler a planilha      Produtos.xlsx

Realizar busca na Kabum
    Acessar KB
    FOR   ${PRODUTO}   IN   @{PRODUTOS}
        Pesquisar e resgatar valor na KB    ${PRODUTO}
    END
    Encerrar navegação na KB
    Log Many    @{PRODUTOS}

Realizar busca no Pichau
    Acessar PC
    FOR   ${PRODUTO}   IN   @{PRODUTOS}
        Pesquisar e resgatar valor na PC    ${PRODUTO}
    END
    Encerrar navegação na PC
    Log Many    @{PRODUTOS}

Realizar busca no Nova Era Shop
    Acessar NE
    FOR   ${PRODUTO}   IN   @{PRODUTOS}
        Pesquisar e resgatar valor na NE    ${PRODUTO}
    END
    Encerrar navegação na NE
    Log Many    @{PRODUTOS}

#Inserir preços no banco de dados