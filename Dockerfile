# Create Builder Image, to compile the source code into an executable
FROM golang:1.20 AS build

WORKDIR /app

# COPY . .
COPY . /app

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o server cmd/server/main.go

# Create the final image, running the API and exposing port 8080
FROM alpine:latest
# FROM scratch

WORKDIR /root

COPY --from=build /app/server ./

EXPOSE 8080

ENTRYPOINT [ "./server" ]
# CMD [ "./server" ]