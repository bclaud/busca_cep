# Busca Cep

Aplicação utilizando Elixir/Phoenix para buscar CEP.

# Rotas:
## Usuarios

Criar seu usuario

- post `http://localhost:4000/api/v1/users`

```
{
    "name": "your name",
    "email": "your email"
    "password": "your password"
  }
```

## Auth

Para usar as operações de CEP abaixo, é necessário se autenticar com um ID e senha validas de um usúario criado acima.

- POST `http://localhost:4000/api/v1/login`
```
{
    "id": integer user id,
    "password": "password of respective user id"
  }
```

## Cep

### buscar CEP

Não se esqueça de adicionar seu token JWT no seu header para utilizar as operações abaixo.

- get `http://localhost:4000/api/v1/cep/{CEP}`


### Relatório CSV com CEPs

- POST `http://localhost:4000/api/v1/cep/report/{email}`

<br>


# Utilização

## Opção 1:

## Execute o projeto através de um container Docker.

Apos clonar o projeto e com o docker devidamente instalado, execute: 

```
docker-compose build

docker-compose up
```

## Opção 2:

## O Phoenix é necessário para executar a API em modo desenvolvedor

```
mix local.hex

mix archive.install hex phx_new
```

## Instalação do projeto

Após clonar o projeto e com um Banco de Dados rodando com os parametros definidos em config/dev.exs, execute:

```
mix deps.get
mix ecto.create
mix ecto.migrate

mix phx.server
```


## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
