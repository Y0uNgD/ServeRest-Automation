*** Settings ***
Documentation   File for automation study purposes using the ServeRest API

Resource        ../Resources/api_testing_users.resource

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

Cenário 03: Consultar os dados de um novo usuário
    Dado criar um novo usuário
    Quando cadastrar o usuário criado na ServeRest    ${EMAIL}    201
    Então consultar os dados do novo usuário
    E conferir os dados retornados

Cenário 04: Logar na plataforma da ServeRest
    Dado criar um novo usuário
    Quando cadastrar o usuário criado na ServeRest    ${EMAIL}    201
    Então realizar o login do usuário criado na ServeRest    ${PASSWORD}
    E conferir se o login foi realizado com sucesso