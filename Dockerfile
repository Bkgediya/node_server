# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/engine/reference/builder/

ARG NODE_VERSION=20.2.0
FROM node:${NODE_VERSION}-alpine AS base

# Set the working directory in the container.
WORKDIR /usr/src/app

# Expose the port your application will run on (if applicable).
EXPOSE 3000

# Copy package.json and package-lock.json to the container.
COPY package*.json ./

# Define the development stage.
FROM base AS dev

# Download dependencies as a separate step.
RUN npm install

# Run the application as a non-root user.
USER node

# Copy the rest of the source files into the image.
COPY . .

# Define the command to start your development environment.
CMD ["npm", "build"]

# Define the production stage.
FROM base AS prod

# Download dependencies as a separate step.
RUN npm install

# Run the application as a non-root user.
USER node

# Copy the rest of the source files into the image.
COPY . .

# Define the command to start your development environment.
CMD ["npm", "build"]

# Define the test stage.
FROM base AS test

# Set the environment to "test."
ENV NODE_ENV test

# Copy package.json and package-lock.json to the container.
COPY package*.json ./


# Install dependencies for testing.
RUN npm install

# Copy the rest of the source files into the image.
COPY . .

# Run the tests.
RUN yarn jest