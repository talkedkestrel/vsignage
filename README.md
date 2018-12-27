# VSignage Project
Cloud managed Digital Signage
This is currently a hobby testing playground using Visionect Development Kit. Sourcecode is currently just a bunch of patchworked Scripts and Apps. Goal is to create a Prototype. Later goal is to run Same Service in Azure IoT Central / Hub and AppService. 

**Setting Up DevKit Lab**
Setup Visionect Docker Machin  
- First Install Docker on Machine then run Docker Commands or use Docker Compose 

**Networking**
The ports in use are:
-  "8081": used for the Visionect Software Suite Management Interface
-  "8000": used for the Digital signage app
-  "11113": used for the TCP connection between your device and the Visionect Software Suite. This port needs to be used 	when configuring your device with the Visionect Configurator.
 ```
# create postgres container
docker run -d --restart=always -e POSTGRES_PASSWORD=visionect -e POSTGRES_USER=visionect -e POSTGRES_DB=koala --name vserver_postgres postgres
# create data container  named 'vdata' (persistent volumes for things like, log files, firmware packages and configuration files)
docker create --name vdata visionect/visionect-server-v3
# run docker container
docker run --privileged --cap-add=MKNOD --cap-add SYS_ADMIN -v /dev/shm:/dev/shm --device /dev/fuse -d --restart=always -p 8081:8081 -p 11112:11112 -p 11113:11113 --link vserver_postgres:db2_1 --volumes-from vdata --name vserver visionect/visionect-server-v3
```

**Start Service**
Change in Directory where docker-compose.yml resides
 ```docker-compose pull && docker-compose up -d ```

**Upgrade Management Server**
 ```
 docker pull visionect/server
 docker stop vserver
 docker rm vserver
 docker run  --privileged --cap-add=MKNOD --cap-add SYS_ADMIN --device /dev/fuse  -d --restart=always -p 8081:8081 -p 11112:11112 -p 11113:11113 --link vserver_postgres:db2_1   --volumes-from vdata --name vserver visionect/server 
```

## Environmental Variables
The following is a list of the environmental variables that can be passed when starting the docker container.
**Database-related Environmental Settings**
The database settings below are mandatory and should be set if you are using an external PostgreSQL server.
`DB2_1_PORT_5432_TCP_ADDR`
The TCP host address of the PostgreSQL server to use
`DB2_1_PORT_5432_TCP_PORT`
The TCP port of the PostgreSQL server
`DB2_1_PORT_5432_TCP_USER`
The PostgreSQL database owner username
`DB2_1_PORT_5432_TCP_PASS`  
The PostgreSQL database owner password
`DB2_1_PORT_5432_TCP_DB`
The PostgreSQL database name to be used for this deployment
**Software Suite Configuration**
The settings below are not mandatory, but should be used to set up a master/slave Software Suite configuration.
`VISIONECT_SERVER_CONFIG`
If set, the content should be a JSON-formatted configuration file that will be used on the first run to store the entire server configuration. Use this if you want to migrate an older config.json configuration to a new Visionect Software Suite 3.x setup.
`VISIONECT_SERVER_DEPLOYMENT_KEY`
If set, the value overrides any set deployment key in the configuration and uses it to identify the components of the deployment
`VISIONECT_SERVER_MASTER_HOST`
If set, the value is used as the master host if setting up a master/slave configuration.
`VISIONECT_SERVER_ENGINE_HOST`
If set, the value is the hostname of the engine if the engine is to be a part of a master/slave server configuration.

- Setup Local Management Server (Hyper-V; Docker)
- Setup Management Server in Cloud (Azure)
- Setup Management Server in AWS
- Configure Device (VisionectConfigurator)
 # Configuration via CLI
Basic Device configuration To enter a command simply type it in and press enter.
-   `help`: Gets a printout of all available commands
-   `sleep_conf_get`: Displays current soft sleep mode setting
-   `conn_type_list`: Lists all the available connections
-   `conn_type_set  <type>`: Sets active connectivity type
-   `conn_type_get`: Prints out the type of connectivity
-   `wifi_conf_set  <ssid>  <psk>  <security>  <band>`: Sets WiFi connection settings
-   `wifi_conf_get`: Gets WiFi configuration
-   `mobile_conf_set  <apn>  <sec>  <usr>  <psk>  <band>`: Sets mobile connection settings
-   `mobile_conf_get`: Gets mobile configuration
-   `flash_save`: Saves settings into FLASH memory
-   `reboot`: Reboots device
-   `fw_version_get`: Shows system’s FW version
-   `uuid_get`: Prints out device’s uuid
- Connect via WLAN to Management Server
- Connect via SIM 
- Document Setup Procedure
- Upload Image

**Define Quality Specs for Image**
 - Resolution (Photoshop)
 - Colorspace (Photoshop)
 - File Format

URL List
 1. Visionect Configurator http://files.visionect.com/VisionectConfigurator2.exe
 2. Visionect Management Server: https://hub.docker.com/r/visionect/visionect-server-v3
