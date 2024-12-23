#!/bin/bash

# Générer le fichier settings.json
echo "Génération de settings.json..."
cat <<EOT > /var/www/html/public/settings.json
{
  "apiUrl": "${BACKEND_PUBLIC_URL:-http://localhost:9000/api}"
}
EOT
echo "settings.json généré avec succès!"

# Démarrer le serveur PHP
php -S 0.0.0.0:9000 -t public
