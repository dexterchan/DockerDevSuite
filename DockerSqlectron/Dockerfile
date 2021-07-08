FROM node:current-alpine3.12

RUN addgroup sqlectron -S && \
    adduser sqlectron -G sqlectron -S && \
    mkdir -p /home/sqlectron/.config/Sqlectron && \
    apk update && \
    apk add git vim && \
    rm -rf /var/cache/apk/* && \
    npm install -g sqlectron-term

USER sqlectron
CMD [ "sqlectron-term" ]