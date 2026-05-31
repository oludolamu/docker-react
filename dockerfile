####### build phase

FROM node:16-alpine AS builder

WORKDIR '/app'
COPY package.json . 

RUN npm install 
COPY . . 

RUN ["npm", "run", "build"]

####### copy results of npm run build and use to run nginx phase -- run is used because it is an image

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

####### deploys to nginx and exposes port for elastic beanstalk use
