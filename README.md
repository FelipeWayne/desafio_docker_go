# Desafio Full Cycle Módulo Docker
## Desafio Go

Esse desafio é muito empolgante principalmente se você nunca trabalhou com a linguagem Go!
Você terá que publicar uma imagem no docker hub. Quando executarmos:

docker run <seu-user>/fullcycle

Temos que ter o seguinte resultado: Full Cycle Rocks!!

Se você perceber, essa imagem apenas realiza um print da mensagem como resultado final, logo, vale a pena dar uma conferida no próprio site da Go Lang para aprender como fazer um "olá mundo".

Lembrando que a Go Lang possui imagens oficiais prontas, vale a pena consultar o Docker Hub.

A imagem de nosso projeto Go precisa ter menos de 2MB =)


## Utilizando o multi-stage build para compilar e otimizar a imagem

# Dockerfile

- Stage 1

```
#Iniciando a imagem do golang para compilar o binário
FROM golang:1.16 AS builder

# Setando o diretório de trabalho
WORKDIR /app

# Copiando o arquivo main.go para o diretório de trabalho
COPY . .

# Compilando o binário
RUN go build -o /app main.go

```

- Stage 2

```
# Strach base debian, serve para imagens mínimas (Que contém apenas um único binários)
# Initando a imagem do scratch para otimizar o tamanho da imagem
FROM scratch

WORKDIR /

# Copiando o binário compilado para a imagem do scratch
COPY --from=builder /app /

# Expondo a porta 8080 para o host da aplicação. Neste caso, o host é o docker.
EXPOSE 8080

# Definindo o comando que será executado ao iniciar o container. Neste caso, o binário compilado do goland.
ENTRYPOINT ["/main"]


```



# Build 
```
docker build -t <seu-user>/fullcycle .
```

# Pull 
```
docker pull felipewayne/fullcycle
```

# Executar o container
```
docker run --rm felipewayne/fullcycle
```


## Repositório DockerHub

- https://hub.docker.com/r/felipewayne/fullcycle