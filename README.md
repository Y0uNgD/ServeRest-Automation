<h1 align="center">Automation ServeRest</h1>

<i><h4 align="center">Automação feita para fins de estudo utilizando o Servidor REST "ServeRest"</h4></i>

<p align="center">
 <img alt="Logo do ServeRest" src="https://user-images.githubusercontent.com/29241659/115161869-6a017e80-a076-11eb-9bbe-c391eff410db.png" height="120">
</p>

_Automation ServeRest_ permite o estudo de:
- Códigos prontos de validação *GET, POST, PUT* e *DELETE* com persistência de dados
- Autenticação via API

<i>OBS: O projeto ainda não está finalizado, portanto, haverá futuras atualizações mostrando outros testes funcionais, como teste de carga, etc.</i>


### Executando a Suíte

Execute o seguinte comando no terminal:

```sh
robot -d .\Results Testing\api_testing_users.robot
```

<i>Após o termino do teste da suíte, abra o arquivo "log.html" para obter os dados.</i>

### Executando teste único

Para executar um caso de teste específico, execute o seguinte comando no terminal:

```sh
robot -d .\Results -t "{Nome Test Case}" Testing\api_testing_users.robot
```

<i>Após o termino do teste da suíte, abra o arquivo "log.html" para obter os dados.</i>
