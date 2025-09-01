# FROM node:16.17.0-alpine as builder
# WORKDIR /app
# COPY ./package.json .
# COPY ./yarn.lock .
# RUN yarn install
# COPY . .
# ARG TMDB_V3_API_KEY
# ENV VITE_APP_TMDB_V3_API_KEY=${TMDB_V3_API_KEY}
# ENV VITE_APP_API_ENDPOINT_URL="https://api.themoviedb.org/3"
# RUN yarn build

# FROM nginx:stable-alpine
# WORKDIR /usr/share/nginx/html
# RUN rm -rf ./*
# COPY --from=builder /app/dist .
# EXPOSE 80
# ENTRYPOINT ["nginx", "-g", "daemon off;"]



# Step 1: Build React app
FROM node:16.17.0-alpine AS builder

WORKDIR /app

# Copy dependencies
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy all source files
COPY . .

# Build the app with environment variables
ARG TMDB_V3_API_KEY
ENV VITE_APP_TMDB_V3_API_KEY=${TMDB_V3_API_KEY}
ENV VITE_APP_API_ENDPOINT_URL="https://api.themoviedb.org/3"
RUN yarn build

# Step 2: Serve with Nginx
FROM nginx:stable-alpine

# Copy built files to Nginx html directory
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80 for Nginx
EXPOSE 80

# Run Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
