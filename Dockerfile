FROM node:18-alpine

USER root

RUN apk add --no-cache git
RUN apk add --no-cache python3 py3-pip make g++
# needed for pdfjs-dist
RUN apk add --no-cache build-base cairo-dev pango-dev

# Install Chromium
RUN apk add --no-cache chromium

ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Install Flowise
RUN npm install -g flowise@latest

WORKDIR /data

# Set environment variables for Flowise credentials
ENV FLOWISE_USERNAME
ENV FLOWISE_PASSWORD

# Set environment variable for port
ENV PORT=3000

# Expose the specified port
EXPOSE ${PORT}

# Start the application with a delay
CMD /bin/sh -c "sleep 3; flowise start --FLOWISE_USERNAME=$FLOWISE_USERNAME --FLOWISE_PASSWORD=$FLOWISE_PASSWORD"
