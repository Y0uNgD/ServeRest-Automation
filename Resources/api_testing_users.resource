*** Settings ***
Library    RequestsLibrary
Library    FakerLibrary
Library    Collections

*** Keywords ***
Criar seção na ServeRest
    ${HEADERS}        Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    ServeRest            https://serverest.dev      ${HEADERS}   

Dado criar um novo usuário
    ${RANDOM_NAME}        FakerLibrary.Name
    ${RANDOM_EMAIL}       FakerLibrary.Email
    ${RANDOM_PASSWORD}    FakerLibrary.Password

    Set Test Variable     ${NAME}        ${RANDOM_NAME}
    Set Test Variable     ${EMAIL}       ${RANDOM_EMAIL}
    Set Test Variable     ${PASSWORD}    ${RANDOM_PASSWORD}

Quando cadastrar o usuário criado na ServeRest
    ${BODY}       Create Dictionary    
    ...           nome=${NAME}    
    ...           email=${EMAIL}    
    ...           password=${PASSWORD}    
    ...           administrador=true
    Log           ${BODY}

    Criar seção na ServeRest

    ${RESPONSE}    POST On Session    
    ...            alias=ServeRest
    ...            url=/usuarios
    ...            json=${BODY}

    Log            ${RESPONSE.json()}

    Set Test Variable    ${RESULT}    ${RESPONSE.json()}

Então conferir se o usuário foi cadastrado corretamente
    Dictionary Should Contain Item    ${RESULT}    
    ...                               message
    ...                               Cadastro realizado com sucesso

    Dictionary Should Contain Key     ${RESULT}    _id