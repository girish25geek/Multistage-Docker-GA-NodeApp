# Stage 1: Build and Install Dependencies
FROM node:18 AS build

# Set working directory inside the container
WORKDIR /app

# Copy only package files first for better layer caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the source code
COPY . .

# Run the build script (assumes you have one in package.json)
RUN npm run build

# Stage 2: Final Slim Production Image
FROM node:18-alpine

# Set working directory again for this stage
WORKDIR /app

# Copy only what's needed: the build output and runtime deps
COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package*.json ./

# Start the app
CMD ["node", "dist/index.js"]
