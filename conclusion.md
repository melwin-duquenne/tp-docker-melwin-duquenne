# Introduction

Pour le projet, j'ai utilisé **Symfony** pour le back-end et **React/Vite** pour le front-end. Pour la base de données, j'ai choisi **MySQL** ainsi que **phpMyAdmin** pour une interface visuelle.  
J'ai créé un système simple pour tester l'interaction entre la base de données, le front-end et le back-end : une connexion et une inscription simplifiées.

# Healthcheck et Portainer

J'ai utilisé Portainer pour le healthcheck, mais aussi pour accéder à mes clusters.  
Il est directement construit dans mon `docker-compose` comme ceci : 

```yaml
portainer:
  image: portainer/portainer-ce
  container_name: portainer
  ports:
    - "9000:9000"
  volumes:
    - /var/run/docker.sock:/var/run/docker.sock
  restart: always
  ```
# Utilisateur différent pour le front et le back
Pour le front-end et le back-end, un utilisateur non-root est utilisé à la place de root dans le Dockerfile :

**créer un utilisateur non-root**
```
RUN addgroup -g 1001 appgroup && \
    adduser -u 1001 -G appgroup -s /bin/sh -D appuser
```
**change la permissions pour l'utilisateur non-root**
```RUN chown -R appuser:appgroup /app```

**passe par l'utilisateur non-root**
```USER appuser```

# Exposition des ports
Tous les conteneurs sont accessibles depuis l'extérieur, sauf le back-end et la base de données, qui sont inaccessibles depuis l'extérieur.
Seul Docker peut fournir les accès nécessaires, configurés dans le docker-compose grâce aux différents réseaux utilisés.
**lien network :**
back-network : pour la connexion entre le front et le back.
back-db-network : pour la connexion entre la base de données, phpMyAdmin et le back-end.

**Ports exposés :**

- Portainer
- phpMyAdmin
- Front-end

**Ports non exposés :**
- Back-end
- Base de données

# Client web pour la base de données

J'ai utilisé phpMyAdmin, connecté à ma base de données.
Voici sa configuration dans le fichier docker-compose :
```
phpmyadmin:
  image: phpmyadmin/phpmyadmin
  container_name: phpmyadminbob
  restart: always
  environment:
    PMA_HOST: db
    PMA_PORT: "${PMA_PORT}"
  ports:
    - "${PORT_PHPADMIN}"
  depends_on:
    - db
  networks:
    - back-db-network
```
# Variables d'environnement

Les variables d'environnement ont été configurées :

Pour le back-end, afin de se connecter à la base de données.
Pour phpMyAdmin, afin de se connecter à la base de données.

# Conclusion

J'ai rencontré plusieurs problèmes sur ce projet. Voici les principaux points :

**Problèmes avec Nginx :**
Au début, j'avais configuré Nginx, mais il posait trop de problèmes avec la création d'un utilisateur non-root. J'ai donc dû le supprimer, ainsi que toutes les modifications associées, et ajuster mon Dockerfile.

**Problèmes avec CORS :**
Les erreurs CORS m'ont bloqué à plusieurs reprises. J'ai fini par comprendre qu'il fallait configurer les CORS à la fois dans Symfony et dans Vite pour résoudre ce problème.

**Exposition du back-end :**
Une des missions demandait que le front-end et le back-end soient exposés, avec un fichier settings.json généré par le back pour le front. Cependant, une autre mission stipulait que le back-end ne devait pas être exposé.
J'ai finalement bloqué l'accès externe au back-end, mais je n'ai pas réussi à implémenter la génération du settings.json.