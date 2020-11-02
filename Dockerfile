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
# the EXPOSE is just sth to read and know for you as a developer
# but adding this command doesn't do anything on your personal laptop
# but on AWS it will read this EXPOSE instruction and it will do the mapping itself 
EXPOSE 80 
COPY --from=builder /app/build /usr/share/nginx/html
# the defualt commend of nginx container starts nginx so no need to write a starting comman

