FROM node:18-alpine

WORKDIR /app 

COPY package*.json ./

RUN npm install --production

EXPOSE 3006

COPY . .

CMD ["node", "app.js"]