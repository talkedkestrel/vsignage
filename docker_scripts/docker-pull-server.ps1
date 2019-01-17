#Download Visionect Server from Docker Hub
docker pull visionect/visionect-server-v3
# create postgres container
docker run -d --restart=always -e POSTGRES_PASSWORD=visionect -e POSTGRES_USER=visionect -e POSTGRES_DB=koala --name vserver_postgres postgres
# create data container  named 'vdata' (persistent volumes for things like, log files, firmware packages and configuration files)
docker create --name vdata visionect/visionect-server-v3
# run docker container
docker run --privileged --cap-add=MKNOD --cap-add SYS_ADMIN -v /dev/shm:/dev/shm --device /dev/fuse -d --restart=always -p 8081:8081 -p 11112:11112 -p 11113:11113 --link vserver_postgres:db2_1 --volumes-from vdata --name vserver visionect/visionect-server-v3
#Check and Logoin to Server 