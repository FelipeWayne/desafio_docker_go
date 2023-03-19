#Iniciando a imagem do golang para compilar o binário
FROM golang:1.16 AS builder

# Setando o diretório de trabalho
WORKDIR /app

# Copiando o arquivo main.go para o diretório de trabalho
COPY . .

# Compilando o binário
RUN go build -o /app main.go


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