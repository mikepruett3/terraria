# Terraria Dedicated Server

Docker Image to run a Dedicated Terraria Server.

## Usage

```bash
docker run \
  --name=terraria \
  --restart unless-stopped \
  --detach \
  -it \
  -v <data-volume-name>:/app/Worlds \
  -e PORT=7777 \
  -p 7777:7777 \
mikepruett3/terraria ./server.sh
```

Where **PORT=** and **Expose Port** Numbers are the same!

Example: Server to run on port 8080

```bash
  -e PORT=8080 \
  -p 8080:8080 \
```


This way a single server can support multiple Terraria Dedicated Server containers.

The container is created as a **Detached** container. If you want to connect to the running Dedicate Server console, use the following command:

```bash
docker attach terraria
```


You can type in **exit** to leave the server console/container, since the restart policy is set to **unless-stopped** the container (and Dedicated Server) will restart automatically.
