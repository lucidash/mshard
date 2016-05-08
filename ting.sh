TITLE=${1:-Ting!}
if [ $# -ge 1 ]
then
  shift
fi
BODY="$*"
curl -XPOST $MSHARD_URI/v2/shards --data pushbullet=true --data type=note --data title="$TITLE" --data body="$BODY"
