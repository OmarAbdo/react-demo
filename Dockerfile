#building phase
# as: tagging the phase
FROM node:alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .

RUN npm run build
# the build folder will be in the container's /app/build

#when docker sees another FROM it understands that 
# we're about ot create another image. no tag needed
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# the defualt commend of nginx container starts nginx so no need to write a starting comman

