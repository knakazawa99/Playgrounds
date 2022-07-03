FROM golang:1.18

COPY go.mod /code/go.mod
COPY go.sum /code/go.sum
WORKDIR /code
RUN go mod download

COPY . /code

CMD go run main.go