#---------Build Phase--------#
## Base image
FROM node:16-alpine as builder

## Working dir
WORKDIR '/app'

## Copy over package.json
COPY package.json .

## Execute command
RUN npm install

## Copy files
COPY . .

## Execute command
RUN npm run build

#--------Run Phase--------#
# Base image (FROM starts a second phase)
FROM nginx

# Copy from builder phase just the "build" file
COPY --from=builder /app/build /usr/share/nginx/html

# We don't have to specify command as nginx takes care of it