#Stage 1: Build the application
FROM node:14 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and yarn.lock files
COPY package.json  ./

# Install the dependencies
RUN yarn install

COPY . .

# Stage 2: Serve the application with Nginx (if applicable)
FROM nginx:alpine

#reate the cache directories and set the permissions.
RUN mkdir -p /var/cache/nginx/client_temp && \
    chown -R nginx:nginx /var/cache/nginx

COPY --from=builder /app /usr/share/nginx/html

# Set environment variable if needed
ENV NODE_ENV=production

# Expose the port the app runs on
EXPOSE 80

# Command to run Nginx
CMD ["nginx", "-g", "daemon off;"]


