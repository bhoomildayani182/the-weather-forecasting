# Step 1: Use node:alpine as the base image
FROM node:alpine AS build

# Step 2: Set working directory
WORKDIR /app

# Step 3: Copy package.json and package-lock.json to install dependencies
COPY package.json package-lock.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the rest of the application files
COPY . .

# Step 6: Build the React application
RUN npm run build

# Step 7: Use nginx:alpine to serve the static files
FROM nginx:alpine

# Step 8: Copy built files to NGINX default html directory
COPY --from=build /app/build /usr/share/nginx/html

# Step 9: Expose port 80
EXPOSE 80

# Step 10: Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
