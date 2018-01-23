FROM alpine:latest

RUN apk add --update \
    git \
    openjdk8 \
    maven && \
  mkdir /build /cah && \
  git clone --depth 1 https://github.com/RoyalDev/TheHumanity /build && \
  cd /build && \
  mvn package && \
  mv *cardpacks example_config.json target/TheHumanity-3.0.0-SNAPSHOT.jar /cah && \
  rm -rf /build && \
  apk del \
    git \
    maven && \
  rm -rf /var/cache/apk/*

RUN adduser -S cah && \
  chown -R cah /cah

USER cah

WORKDIR /cah

CMD ["java", "-jar", "./TheHumanity-3.0.0-SNAPSHOT.jar", "-c", "config.json"]
