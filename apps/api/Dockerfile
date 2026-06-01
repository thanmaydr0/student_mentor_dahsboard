FROM node:18-alpine

WORKDIR /app

# Copy root package.json if you are using workspaces (monorepo), or just the api package
COPY package*.json ./
COPY apps/api/package*.json ./apps/api/

# Install dependencies
RUN npm install

# Copy source code
COPY apps/api/ ./apps/api/

WORKDIR /app/apps/api

# Expose the API port
EXPOSE 3000

# Start the Express server
CMD ["npm", "run", "dev"]
