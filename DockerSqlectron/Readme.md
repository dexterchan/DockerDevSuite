## simple
docker run -ti pigpiggcp/sqlectron-term:v0


## Persisting state locally:

docker run -ti -v \
$PWD/Sqlectron:/home/sqlectron/.config/Sqlectron \
pigpiggcp/sqlectron-term:v0