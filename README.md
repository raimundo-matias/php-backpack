<img src="icon.png" align="right" />

# [PHP backpack](https://github.com/raimundo-matias/php-backpack#readme.md)

> Um ambiente de *desenvolvimento local* para aplicações PHP "do jeito certo"

## Características

Este projeto provê um ambiente de **desenvolvimento local PHP** baseado em **docker**, contendo as seguintes tecnologias:

✓ Servidor Web Apache 2.4\
✗ Backend PHP-FPM 7.4\
✗ PHP Composer\
✗ XDebug\
✗ Banco de dados PostgreSQL 9.4

Além das tecnologias descritas, este projeto também disponibiliza a criação de **ServerName** e **SSL auto-assinado** de forma automatizada, e, habilitada por padrão no servidor web.

## Estrutura

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

## Como utilizar este projeto

1. Clone este projeto ;)

    ```bash
    git clone https://github.com/user/raimundo-matias/php-backpack
    ```

2. Crie o arquivo de configuração de ambiente

    ```bash
    cd php-backpack && cp env-example .env
    ```

3. Altere o valor da variável `SSL_DOMAIN` do arquivo `.env` conforme desejar, e, adicione este nome no arquivo hosts do seu sistema operacional

4. Execute o arquivo de criação dos certificados

    ```bash
    source conf/apache/create-certs.sh
    ```

5. Após a finalização do script, importe o arquivo `conf/apache/rootCA.crt` em seu navegador:

    <img alt="Mozilla" src="https://simpleicons.org/icons/mozillafirefox.svg" width="13px" /> Firefox

    `Menu` ➔ `Preferências` ➔ `Privacidade e Segurança` ➔ `Visualizar Certificados` ➔ `aba: Autoridades` ➔ `botão: Importar`

    <img alt="Google" src="https://simpleicons.org/icons/googlechrome.svg" width="13px" /> Chrome

    `Menu` ➔ `Configurações` ➔ `Privacidade e Segurança` ➔ `Gerenciar Certificados` ➔ `aba: Autoridades` ➔ `botão: Importar`

6. Execute o docker-compose e seja feliz!

    ```bash
    docker-compose up --build
    ```

## Créditos

I thank all the people in the technology community who shared their efforts and knowledge so that I could do this job!

In particular, I am grateful for the following references:

- [Base concept's and initial's reference for SSL](https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309)
- [SSL Automation](https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309)
- [Container httpd with SSL concept](https://github.com/InAnimaTe/docker-httpd-ssl)
- [Container php-fpm with PHP Composer and XDebug](https://github.com/GaetanRole/php-docker-starter)
