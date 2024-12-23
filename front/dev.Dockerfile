# dev.Dockerfile
FROM node:20-alpine

# Créer un utilisateur non-root
RUN addgroup -g 1001 appgroup && \
    adduser -u 1001 -G appgroup -s /bin/sh -D appuser
# Définir le répertoire de travail
WORKDIR /app
# Copier les fichiers du projet
COPY package*.json .

RUN npm install 

COPY . .

# Changer les permissions pour l'utilisateur non-root
RUN chown -R appuser:appgroup /app


# Passer à l'utilisateur non-root
USER appuser

# Démarrer le serveur de développement
EXPOSE 3000
CMD ["npm", "run", "dev"]
