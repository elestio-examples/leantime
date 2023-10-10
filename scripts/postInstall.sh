#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 45s;

target=$(docker-compose port leantime 80)

curl http://${target}/install \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'pragma: no-cache' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36' \
  --data-raw 'email='${ADMIN_EMAIL}'&password='${ADMIN_PASSWORD}'&firstname=root&lastname=root&company=root&install=Install' \
  --compressed