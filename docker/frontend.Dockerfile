# Use an official Node.js runtime as a parent image
FROM node:20-alpine AS build
# Set the working directory in the container
WORKDIR /app
# Copy the package.json and package-lock.json files
COPY package*.json ./
# Install dependencies
RUN npm install
# Copy the rest of the application code
COPY . .
# Build the React app
RUN npm run build

# Install a lightweight web server to serve the build (nginx)
FROM nginx:alpine
# Copy the build folder to the nginx container
COPY --from=build /app/build /usr/share/nginx/html
# Copy the Nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf
# Expose port 8080
EXPOSE 8080
# Start nginx
CMD ["nginx", "-g", "daemon off;"]
