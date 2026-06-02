*** Settings ***
Library          SeleniumLibrary

Suite Setup      Inicializar Ambiente Web
Suite Teardown   Encerrar Ambiente Web

*** Variables ***
${ENDERECO_URL}     http://localhost:3000
${NAVEGADOR}        chrome

${CMB_PORTA}        id=gate
${CMB_INPUT_A}      id=inputA
${CMB_INPUT_B}      id=inputB
${BOT_DISPARAR}     id=btnGate
${ZONA_RETORNO}     id=resultGate

*** Test Cases ***

Cenário 01: Validação do Circuito AND (True)
    Configurar Operadores Web    AND    1    1
    Disparar Cálculo Em Tela
    Verificar Texto No Painel    "saida": 1

Cenário 02: Validação do Circuito OR (False)
    Configurar Operadores Web    OR     0    0
    Disparar Cálculo Em Tela
    Verificar Texto No Painel    "saida": 0

Cenário 03: Validação do Circuito NOT (Inversão)
    Configurar Operadores Web    NOT    1    0
    Disparar Cálculo Em Tela
    Verificar Texto No Painel    "saida": 0

Cenário 04: Validação do Circuito XOR (Nulo)
    Configurar Operadores Web    XOR    1    1
    Disparar Cálculo Em Tela
    Verificar Texto No Painel    "saida": 0

*** Keywords ***

Inicializar Ambiente Web
    Open Browser    ${ENDERECO_URL}    ${NAVEGADOR}
    Maximize Browser Window
    Wait Until Element Is Visible    ${CMB_PORTA}    timeout=10s

Encerrar Ambiente Web
    Close Browser

Configurar Operadores Web
    [Arguments]    ${operador}    ${bit_a}    ${bit_b}
    Select From List By Value    ${CMB_PORTA}      ${operador}
    Select From List By Value    ${CMB_INPUT_A}    ${bit_a}
    # Condicional de segurança caso a interface esconda o seletor B (Comportamento do NOT)
    ${visivel}    Run Keyword And Return Status    Element Should Be Visible    ${CMB_INPUT_B}
    IF    ${visivel}
        Select From List By Value    ${CMB_INPUT_B}    ${bit_b}
    END

Disparar Cálculo Em Tela
    Click Button    ${BOT_DISPARAR}

Verificar Texto No Painel
    [Arguments]    ${conteudo}
    Wait Until Element Is Visible    ${ZONA_RETORNO}    timeout=5s
    Element Should Contain    ${ZONA_RETORNO}    ${conteudo}