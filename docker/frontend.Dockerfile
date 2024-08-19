# Step 1: Build the React app
FROM node:20 AS build

WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the app for production
RUN npm run build

# Step 2: Serve the React app using a lightweight web server
FROM nginx:alpine

# Copy the build output to the nginx html directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose the port nginx will serve on
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
