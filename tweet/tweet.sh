#!/bin/bash

urlencode () {
        [ -n "$1" ] \
        && echo -n "$1" | perl -p -e 's/([^A-Za-z0-9-._~])/sprintf("%%%02X", ord($1))/seg'
}

#oauth1 vars
consumer_key=""
consumer_secret=""
token=""
token_secret=""

signature_method='HMAC-SHA1'
timestamp=$(date +%s)
nonce=$(md5 <<< "$RANDOM-$(date +%s.%N)" | cut -d' ' -f 1) # md5sum on linux
PARAM=$(urlencode "oauth_consumer_key=$consumer_key&oauth_nonce=$nonce&oauth_signature_method=$signature_method&oauth_timestamp=$timestamp&oauth_token=$token&oauth_version=1.0")
apiv2="https://api.twitter.com/2/tweets"
apiv1="https://upload.twitter.com/1.1/media/upload.json"

upload_media () {
    body="media=@$1"
    encodedURL=$(urlencode $apiv1)
    signature=$(echo -n 'POST&'$encodedURL'&'$PARAM|openssl dgst -sha1 -binary -hmac "$consumer_secret&$token_secret" |base64)
    encoded_signature=$(urlencode $signature)
    media_id=$(curl -v $apiv1 \
		    -H "Authorization: OAuth oauth_consumer_key=\"$consumer_key\",oauth_token=\"$token\",oauth_signature_method=\"$signature_method\",oauth_timestamp=\"$timestamp\",oauth_nonce=\"$nonce\",oauth_version=\"1.0\",oauth_signature=\"$encoded_signature\"" \
		    -H 'cache-control: no-cache' \
		    -F $body |jq '.media_id_string')
}

if [ $# -eq 1 ]; then
    content="{ \"text\" : \"$1\"}"
elif [ $# -eq 2 ]; then
    upload_media $2
    content="{ \"text\" : \"$1\", \"media\": {\"media_ids\": [$media_id]}}"
else
    echo "Usage: $0 <text> [media_path]"
    echo "Please provide one or two arguments"
    exit 0
fi

encodedURL=$(urlencode $apiv2)
signature=$(echo -n 'POST&'$encodedURL'&'$PARAM|openssl dgst -sha1 -binary -hmac "$consumer_secret&$token_secret" |base64)
encoded_signature=$(urlencode $signature)

curl -v $apiv2 \
  -H "Authorization: OAuth oauth_consumer_key=\"$consumer_key\",oauth_token=\"$token\",oauth_signature_method=\"$signature_method\",oauth_timestamp=\"$timestamp\",oauth_nonce=\"$nonce\",oauth_version=\"1.0\",oauth_signature=\"$encoded_signature\"" \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d "$content"
