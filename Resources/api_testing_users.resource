*** Settings ***
Documentation  Configuration file using Gherkin BDD to implement test cases  

Library        RequestsLibrary
Library        FakerLibrary
Library        Collections
Library        Telnet

*** Keywords ***
############################################################################################################
# STARTING A API SESSION
############################################################################################################

Criar seção na ServeRest
    ${HEADERS}        Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    ServeRest            https://serverest.dev      ${HEADERS}   

############################################################################################################
# "DADO"
############################################################################################################

Dado criar um novo usuário
    ${RANDOM_NAME}        FakerLibrary.Name
    ${RANDOM_EMAIL}       FakerLibrary.Email
    ${RANDOM_PASSWORD}    FakerLibrary.Password

    Set Test Variable     ${NAME}        ${RANDOM_NAME}
    Set Test Variable     ${EMAIL}       ${RANDOM_EMAIL}
    Set Test Variable     ${PASSWORD}    ${RANDOM_PASSWORD}

############################################################################################################
# "QUANDO"
############################################################################################################

Quando cadastrar o usuário criado na ServeRest
    [Arguments]    ${EMAIL}    ${EXPECTED_STATUS_CODE}
    ${BODY}        Create Dictionary    
    ...            nome=${NAME}    
    ...            email=${EMAIL}    
    ...            password=${PASSWORD}    
    ...            administrador=true
    Log            ${BODY}

    Criar seção na ServeRest

    ${RESPONSE}    POST On Session    
    ...            alias=ServeRest
    ...            url=/usuarios
    ...            json=${BODY}
    ...            expected_status=${EXPECTED_STATUS_CODE}

    Log            ${RESPONSE.json()}

    IF    ${RESPONSE.status_code} == 201
        Set Test Variable    ${USER_ID}   ${RESPONSE.json()["_id"]}
    END

    Set Test Variable    ${RESULT}    ${RESPONSE.json()}

############################################################################################################
# ENTÃO
############################################################################################################

Então conferir se o usuário foi cadastrado corretamente
    Dictionary Should Contain Item    ${RESULT}    
    ...                               message
    ...                               Cadastro realizado com sucesso

    Dictionary Should Contain Key     ${RESULT}    _id

Então repetir o cadastro do usuário
    Quando cadastrar o usuário criado na ServeRest    ${EMAIL}    400

E verificar se a API não permite o cadastro
    Dictionary Should Contain Item    ${RESULT}    
    ...                               message
    ...                               Este email já está sendo usado

Então consultar os dados do novo usuário
    ${CONSULT_RESPONSE}               GET On Session    
    ...                               ServeRest    
    ...                               /usuarios/${USER_ID}
    Set Test Variable                 ${CONSULT_RESULT}    ${CONSULT_RESPONSE.json()}

Então realizar o login do usuário criado na ServeRest
    [Arguments]    ${PASSWORD}
    ${BODY}        Create Dictionary
    ...            email=${EMAIL}
    ...            password=${PASSWORD}
    Log            ${BODY}

    ${RESPONSE}    POST On Session
    ...            alias=ServeRest
    ...            url=/login
    ...            json=${BODY}
    
    Log            ${RESPONSE.json()}
    
    Set Test Variable    ${RESULT_LOGIN}    ${RESPONSE.json()}
############################################################################################################
# "E"
############################################################################################################

E conferir os dados retornados
    Log                              ${CONSULT_RESULT}
    Dictionary Should Contain Item   ${CONSULT_RESULT}    nome                 ${NAME}
    Dictionary Should Contain Item   ${CONSULT_RESULT}    email                ${EMAIL}
    Dictionary Should Contain Item   ${CONSULT_RESULT}    password             ${PASSWORD}
    Dictionary Should Contain Item   ${CONSULT_RESULT}    administrador        true
    Dictionary Should Contain Item   ${CONSULT_RESULT}    _id                  ${USER_ID}

E conferir se o login foi realizado com sucesso
    Dictionary Should Contain Item    ${RESULT_LOGIN}    
    ...                               message    
    ...                               Login realizado com sucesso

    Dictionary Should Contain Key    ${RESULT_LOGIN}    
    ...                              authorization