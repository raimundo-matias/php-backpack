<img src="icon.png" align="right" />

# [PHP backpack](https://github.com/raimundo-matias/php-backpack#readme.md)

> Um ambiente de *desenvolvimento local* para aplicações PHP

## Características

Este projeto provê um ambiente de **desenvolvimento local PHP** baseado em docker, contendo as seguintes tecnologias:

1. Servidor Web Apache 2.4
2. Backend PHP-FPM 7.4
3. Banco de dados PostgreSQL 9.4
4. XDebug
5. PHP Composer

Além das tecnologias descritas, este projeto também disponibiliza a criação de **ServerName** e **SSL auto-assinado** de forma automatizada, e, habilitada por padrão. Porém, para utilizar estes recursos, é necessário executar as seguintes ações:

1. Adicionar o domínio (`SSL_DOMAIN`), que foi definino no arquivo [`.env`](.env-example) ao arquivo hosts do seu S.O.

2. Após finalizar o roteiro, adicionar o arquivo `conf/apache/rootCA.crt` no seu navegador, detalhes sobre como importar certificados de autoridade (CA) neste [post](https://matias.one/ssl-auto-assinado-com-CA).

## Estrutura do projeto após execução do roteiro

```bash
.
├── app
│   └── # DISPONIBILIZE SUA APLICAÇÃO AQUI
├── conf
│   └── apache
│       ├── server.crt
│       ├── server.key
│       ├── rootCA.crt # IMPORTE ESTE ARQUIVO EM SEU NAVEGADOR
│       └── Dockerfile
├── docker-compose.yml
├── .env-example
├── .gitignore
└── README.md
```

## Utilizando o projeto

1. Clone este projeto ;)

    ```bash
    git clone https://github.com/user/raimundo-matias/php-backpack
    ```

2. Crie o arquivo de configuração de ambiente

    ```bash
    cd php-backpack && cp env-example .env
    ```

3. Altere o valor da variável `SSL_DOMAIN` do arquivo `.env` conforme desejar, e execute o arquivo de criação dos certificados

    ```bash
    source conf/apache/create-certs.sh
    ```

    > Após a finalização do script, importe o arquivo `conf/apache/rootCA.crt` em seu navegador, mais detalhes [aqui](https://matias.one/ssl-auto-assinado-com-CA)

4. Execute o docker-compose e seja feliz!

    ```bash
    docker-compose up --build
    ```

## Créditos

I thank all the people in the technology community who shared their efforts and knowledge so that I could do this job!

In particular, I am grateful for the following references:

- [Base concept's and initial's reference](https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309)
- [SSL Automation](https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309)
- [Container httpd with SSL concept](https://github.com/InAnimaTe/docker-httpd-ssl)
