exist=$(docker volume ls -f name=$1)
if [[ "$exist" == *"$1"* ]]
then
    echo 'ERROR Volume already exist'
else
    echo 'Creating volume'
    docker volume create $1
    docker run --rm -v $1:/data_backup -v "$(pwd):/backup" ubuntu bash -c "cd /data_backup && gunzip -c /backup/$1.tar.gz > /backup/$1.tar && tar xvf /backup/$1.tar --strip 1 && rm /backup/$1.tar"
fi