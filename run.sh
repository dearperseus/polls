docker system prune -a && docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)

# запустить контейнеры в фоне
docker-compose up -d

# вывести информацию по контейнерам
docker-compose ps

echo
echo

# Тестирование
echo Testing...

# GET запрос /status
echo get service status:
STATUS_RES=`curl -s -X GET http://localhost:8080/status`
echo $STATUS_RES
echo

# POST /create_poll
echo create poll:
CREATE_POLL_RES=`curl -s -X POST -H "Content-Type: application/json" -d '{"title": "some title", "description": "some description"}' http://localhost:8080/create_poll`
echo $CREATE_POLL_RES
echo

POLL_ID=`echo $CREATE_POLL_RES| cut -d':' -f 2| cut -d',' -f 1`

# POST /get_poll/:id
echo get poll with ID $POLL_ID:
GET_POLL_RES=`curl -s -X GET http://localhost:8080/get_poll/$POLL_ID`
echo $GET_POLL_RES
echo

# POST /delete_poll/:id
echo delete poll with ID $POLL_ID:
_=`curl -s -X DELETE http://localhost:8080/delete_poll/$POLL_ID`

GET_POLL_RES=`curl -s -X GET http://localhost:8080/get_poll/$POLL_ID`

if [ -n $GET_POLL_RES]
then echo "poll with ID $POLL_ID is deleted"
else echo "failed to delete poll with ID $POLL_ID"
fi