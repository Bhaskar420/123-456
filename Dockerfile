
#stage 1: Build the application
FROM node:14 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and yarn.lock files
COPY package.json yarn.lock ./

# Install the dependencies
RUN yarn install --production

# Copy the rest of the application code
COPY . .

# Build the app (if applicable)
# RUN yarn build (Uncomment if you have a build step)

# Stage 2: Serve the application with Nginx
FROM nginx:alpine

# Copy the built application from the builder stage
COPY --from=builder /app/build /usr/share/nginx/html

# Copy a custom nginx configuration file (if you have one)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Set environment variable
ENV NODE_ENV=production

# Expose the port the app runs on
EXPOSE 80

# Command to run Nginx
CMD ["nginx", "-g", "daemon off;"]
