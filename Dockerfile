FROM openjdk:11

RUN apt-get install plantuml

COPY entrypoint.sh /entrypoint.sh
COPY structurizr-cli /structurizr-cli

ENTRYPOINT ["/entrypoint.sh"]
