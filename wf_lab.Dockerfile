FROM golang:1.17-buster AS build

WORKDIR /apps

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /gha-charles

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /gha-charles /gha-charles

USER nonroot:nonroot

ENTRYPOINT ["/gha-charles"]