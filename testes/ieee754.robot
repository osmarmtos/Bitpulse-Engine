*** Settings ***
Library          SeleniumLibrary

Suite Setup      Iniciar Navegador No BitPulse
Suite Teardown   Desligar Navegador

*** Variables ***
${ALVO_URL}         http://localhost:3000
${BROWSER_TYPE}     chrome

${TXT_VALOR}        id=valor
${BTN_CONVERTER}    id=btnIeee
${PANEL_RESULT}     id=resultIeee

*** Test Cases ***

Cenário 01: Inserção de Número Positivo
    O valor decimal "0.5" é inserido no painel
    O botão de processamento IEEE é acionado
    A interface deve exibir a propriedade '"sinal": "0"'

Cenário 02: Inserção de Número Negativo
    O valor decimal "-3.14" é inserido no painel
    O botão de processamento IEEE é acionado
    A interface deve exibir a propriedade '"sinal": "1"'

Cenário 03: Inserção do Limite Zero
    O valor decimal "0" é inserido no painel
    O botão de processamento IEEE é acionado
    A interface deve exibir a propriedade '"binario32": "00000000000000000000000000000000"'

*** Keywords ***

Iniciar Navegador No BitPulse
    Open Browser    ${ALVO_URL}    ${BROWSER_TYPE}
    Maximize Browser Window
    Wait Until Element Is Visible    ${TXT_VALOR}    timeout=10s

Desligar Navegador
    Close Browser

O valor decimal "${valor}" é inserido no painel
    Wait Until Element Is Visible    ${TXT_VALOR}    timeout=5s
    Press Keys    ${TXT_VALOR}    CTRL+a+BACKSPACE
    Input Text    ${TXT_VALOR}    ${valor}

O botão de processamento IEEE é acionado
    Click Button    ${BTN_CONVERTER}

A interface deve exibir a propriedade '${saida_esperada}'
    Wait Until Element Is Visible    ${PANEL_RESULT}    timeout=5s
    Element Should Contain    ${PANEL_RESULT}    ${saida_esperada}