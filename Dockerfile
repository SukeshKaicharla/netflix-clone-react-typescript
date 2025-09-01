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

# Copy package.json and lock files if available
COPY package.json ./
COPY yarn.lock* package-lock.json* ./

# Install dependencies with yarn if available, else npm
RUN if [ -f yarn.lock ]; then yarn install --frozen-lockfile; \
    else npm install; fi

# Copy project files
COPY . .

# Ensure build script exists before running
ARG TMDB_V3_API_KEY
ENV VITE_APP_TMDB_V3_API_KEY=${TMDB_V3_API_KEY}
ENV VITE_APP_API_ENDPOINT_URL="https://api.themoviedb.org/3"

# Only run build if script is present
RUN if yarn run | grep -q "build"; then yarn build; \
    elif npm run | grep -q "build"; then npm run build; \
    else echo "⚠️ No build script found, skipping build"; fi

# Step 2: Serve with Nginx
FROM nginx:stable-alpine

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
