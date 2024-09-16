FROM node:18
WORKDIR /usr/src/app

RUN npm install

EXPOSE 8080

CMD ["ping google.com"]
