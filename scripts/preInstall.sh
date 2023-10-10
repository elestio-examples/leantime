#set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p storage/public_userfiles storage/userfiles
chmod 777 -R storage/public_userfiles storage/userfiles


cat /opt/elestio/startPostfix.sh > post.txt
filename="./post.txt"

SMTP_LOGIN=""
SMTP_PASSWORD=""

while IFS= read -r line; do
  values=$(echo "$line" | grep -o '\-e [^ ]*' | sed 's/-e //')

  while IFS= read -r value; do
    if [[ $value == RELAYHOST_USERNAME=* ]]; then
      SMTP_LOGIN=${value#*=}
    elif [[ $value == RELAYHOST_PASSWORD=* ]]; then
      SMTP_PASSWORD=${value#*=}
    fi
  done <<< "$values"

done < "$filename"

cat << EOT >> ./.env

LEAN_EMAIL_SMTP_HOSTS=tuesday.mxrouting.net
LEAN_EMAIL_SMTP_PORT=25
LEAN_EMAIL_RETURN=${SMTP_LOGIN}
LEAN_EMAIL_SMTP_USERNAME=${SMTP_LOGIN}
LEAN_EMAIL_SMTP_PASSWORD=${SMTP_PASSWORD}
EOT


rm post.txt