*** Settings ***
Resource    ../Resources/api_testing_users.resource

*** Test Cases ***
Cenário 01: Cadastrar um novo usuário com sucesso na ServeRest
    Dado criar um novo usuário
    Quando cadastrar o usuário criado na ServeRest
    Então conferir se o usuário foi cadastrado corretamente