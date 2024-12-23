# introduction
Pour le projet j'ai utilise Symfony pour le back et React/vite pour le front, pour la base de donner j'ai choisi mysql ainsi que phpmyadmin pour un visuel. j'ai créer un systéme simple pour tester j'ai fait une connexion et inscription simplifier afin de voir si il y bien une intéraction avec la base de donnée, le front et le back.


# healthcheck et portainer 

j'ai utiliser portainer pour le healthcheck mais aussi pour accéder a mes cluster.
il est importait directement construie dans mon docker-compose comme ceci : 
portainer:
      image: portainer/portainer-ce
      container_name: portainer
      ports:
        - "9000:9000"
      volumes:
        - /var/run/docker.sock:/var/run/docker.sock
      restart: always

# utilisateur différent pour le front et back

la partit front et back un autre utilisateur est utilisé a place de root dans docketfile:

créer un utilisateur non-root
RUN addgroup -g 1001 appgroup && \
    adduser -u 1001 -G appgroup -s /bin/sh -D appuser

change la permissions pour l'utilisateur non-root
RUN chown -R appuser:appgroup /app

passe par l'utilisateur non-root
USER appuser

# exposition des port

tout les conteneur son accécible par l'extérieur sauf le back et la bdd qui sont eux innacecible par l'extérieur seul docker peux donner les accées qui sont configurer dans le docker-compose grace au différent network utilisé. 

back-network : pour la connexion entre le front et le back.

back-db-network : lui permet la connexion entre la bdd, phpmyadmin et le back.

port exposé : 
- portainer
- phpmyadmin
- front 

port non exposé :
- back
- bdd

# clien web pour la BDD 

j'ai utilisé donc phpmyadmin qui est connecté a ma base de donnée, il est créer avec docker-compose comme ceci: 

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

# variable d'environnement 

celle de la bdd a était configuer pour le back ainsi que dans bd pour la bdd, phpmyadmin utilise la variable d'environement pour se connecter a la bdd.

# conclusion 

j'ai eux beaucoup de probléme sur le petit projet a cose de la mise en place au début j'avais commencé avec nginx mais il pausait trop de problème avec la création d'un utilisateur non root donc j'ai du le supprimer tout les modification que j'avais réaliser et modifier mon dockerfile. j'ai eu aussi beaucoup de probléme avec l'origine cors qui ma bloquer pas mal de fois jusqua que je comprenne que si je le configure dans symfony et que je le passe dans vite sa résous le problème. dans les missions qui sont confié il y a quelque chose qui ma un peux bloqué car il y a une partit qui demande que le front et back soit exposé puis que le back créer un settings.json pour le front, mais la mission d'aprés il y a marquer que le back ne doit pas être exposé pour l'extérieur donc j'avoue que je savais pas trop quoi faire donc j'ai juste bloquer le back de l'extérieur car je n'ai malheuresement pas réussi avec le settings.json.