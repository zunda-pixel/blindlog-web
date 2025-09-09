FROM swift:latest

WORKDIR /build

COPY . .

RUN swift build -c release

CMD ./Server --hostname 0.0.0.0 --port $PORT