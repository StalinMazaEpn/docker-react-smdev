# BUILD PHASE
# Use an image with nodejs preinstalled using alpine linux image
FROM node:16-alpine as builder
# Configure working directory to not use main root directory of container
WORKDIR '/app'
# Copy first only package json file neccesary to install dependencies
COPY package.json .
# Install dependencies
RUN npm install
# Copy another files related of project to avoid execute npm install in next builds if it´s not neccesary
COPY . .
RUN npm run build


# RUN PHASE
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# This image doesn´t need any start command due to nginx does the job by itself