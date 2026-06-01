*** Settings ***
Library    SeleniumLibrary

Suite Setup       Abrir navegador
Suite Teardown    Fechar navegador

*** Variables ***
${URL}              http://localhost:3000
${BROWSER}          chrome

${INPUT_VALOR}      id=valor
${BTN_IEEE}         id=btnIeee
${RESULT_IEEE}      id=resultIeee

*** Test Cases ***

CT01 - Numero positivo deve retornar sinal 0
    Informar valor    0.5
    Clicar em converter
    Resultado deve conter    "sinal": "0"

CT02 - Numero negativo deve retornar sinal 1
    Informar valor    -3.14
    Clicar em converter
    Resultado deve conter    "sinal": "1"

CT03 - Valor zero deve retornar binario com 32 zeros
    Informar valor    0
    Clicar em converter
    Resultado deve conter    "binario32": "00000000000000000000000000000000"

*** Keywords ***

Abrir navegador
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${INPUT_VALOR}    timeout=10s

Fechar navegador
    Close Browser

Informar valor
    [Arguments]    ${valor}
    Go To    ${URL}
    Wait Until Element Is Visible    ${INPUT_VALOR}    timeout=10s
    Clear Element Text    ${INPUT_VALOR}
    Input Text    ${INPUT_VALOR}    ${valor}

Clicar em converter
    Click Button    ${BTN_IEEE}
    Wait Until Element Is Visible    ${RESULT_IEEE}    timeout=10s

Resultado deve conter
    [Arguments]    ${texto}
    Element Should Contain    ${RESULT_IEEE}    ${texto}