*** Settings ***
Resource    ../Resources/api_testing_users.resource

*** Test Cases ***
Cenário 01: Cadastrar um novo usuário com sucesso na ServeRest
    Dado criar um novo usuário
    Quando cadastrar o usuário criado na ServeRest    ${EMAIL}    201
    Então conferir se o usuário foi cadastrado corretamente

Cenário 02: Cadastrar um usuário já existente
    Dado criar um novo usuário
    Quando cadastrar o usuário criado na ServeRest    ${EMAIL}    201
    Então repetir o cadastro do usuário
    E verificar se a API não permite o cadastro