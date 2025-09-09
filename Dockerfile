FROM swift:latest

WORKDIR /build

COPY . .

RUN swift build -c release

EXPOSE $PORT

CMD ./Server --hostname 0.0.0.0 --port $PORT
