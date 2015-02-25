docker build --no-cache -t boot2docker-nfs .
docker run --rm boot2docker-nfs > boot2docker-nfs.iso
cp boot2docker-nfs.iso ~/.boot2docker/
boot2docker stop
mv ~/.boot2docker/boot2docker-nfs.iso ~/.boot2docker/boot2docker.iso
boot2docker up
boot2docker ssh
