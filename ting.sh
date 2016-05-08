TITLE=$1
BODY="$*"
curl -XPOST $MSHARD_URI/v2/shards --data pushbullet=true --data type=note --data title="$TITLE" --data body="$BODY"
