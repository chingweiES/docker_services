# Create a script to create two docker-compose files for the example
# docker-compose-master.yml and docker-compose-slave.yml for postgres 16

#!/bin/bash

# Show warning message: the script will create a docker external network, let user confirm before proceeding
echo "This script will create a docker external network named 'mydb_streaming_net'."
read -p "Do you want to proceed? (y/n) " -n 1 -r
# show the date and time in echo
echo    # move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')]: CancelCase: Exiting."
    exit 1
fi

# create a network for the containers
docker network create mydb_streaming_net

echo "[$(date '+%Y-%m-%d %H:%M:%S')]: Docker external network 'mydb_streaming_net' created successfully."

# Create docker-compose-master.yml
cat <<EOF > docker-compose-master.yml
version: '3.8'
services:
  postgres-master:
    project: postgres-master-proj
    image: postgres:16
    container_name: postgres-master
    environment:
      POSTGRES_USER: mydbuser
      POSTGRES_PASSWORD: mydbuseradmin
      POSTGRES_DB: masterdb
    command: >
      postgres
      -c wal_level=replica
      -c max_wal_senders=10
      -c max_replication_slots=10
      -c hot_standby=on    
    ports:
      - "8006:5432"
    volumes:
      - master-data:/var/lib/postgresql/data
    networks:
      - mydb_streaming_net

networks:
  mydb_streaming_net:
    external: true

volumes:
  master-data:
EOF

# Create docker-compose-slave.yml
cat <<EOF > docker-compose-slave.yml
version: '3.8'
services:
  postgres-slave:
    project: postgres-slave-proj
    image: postgres:16
    container_name: postgres-slave
    depends_on:
      - postgres-master
    environment:
      POSTGRES_USER: mydbuser
      POSTGRES_PASSWORD: mydbuseradmin
    entrypoint: >
      bash -c "
      until pg_isready -h postgres-master -U mydbuser; do
        echo 'Waiting for master...';
        sleep 2;
      done;
      if [ ! -s /var/lib/postgresql/data/PG_VERSION ]; then
        echo 'Starting base backup from master...';
        # key point: provide password for pg_basebackup
        PGPASSWORD=mydbuseradmin pg_basebackup -h postgres-master -D /var/lib/postgresql/data -U mydbuser -vP -R;
      fi;
      exec docker-entrypoint.sh postgres
      "
    ports:
      - "8007:5432"
    volumes:
      - slave-data:/var/lib/postgresql/data
    networks:
      - mydb_streaming_net

networks:
  mydb_streaming_net:
    external: true

volumes:
  slave-data:
EOF
echo "[$(date '+%Y-%m-%d %H:%M:%S')]: Docker Compose files 'docker-compose-master.yml' and 'docker-compose-slave.yml' created successfully."


echo "[$(date '+%Y-%m-%d %H:%M:%S')]: Creating configuration file 'haproxy.cfg' for HAProxy load balancer..."
# Create haproxy.cfg for load balancing
cat <<EOF > haproxy.cfg
# haproxy.cfg
defaults
    mode tcp
    # 解決警告：加上必要的超時設定
    timeout connect 5s
    timeout client 30m
    timeout server 30m

frontend pg_frontend
    bind *:5432
    default_backend pg_master_backend

backend pg_master_backend
    mode tcp
    option tcp-check
    # 這裡的名稱必須與 container_name 一致
    server master postgres-master:5432 check inter 5s fall 3 rise 2
    server slave  postgres-slave:5432  check inter 5s fall 3 rise 2 backup
EOF
echo "[$(date '+%Y-%m-%d %H:%M:%S')]: Configuration file 'haproxy.cfg' created successfully."



# Create docker-compose-proxy.yml
echo "[$(date '+%Y-%m-%d %H:%M:%S')]: Creating Docker Compose file 'docker-compose-proxy.yml' for HAProxy load balancer..."
cat <<EOF > docker-compose-proxy.yml
services:
  proxy:
    project: postgres-proxy-proj
    image: haproxy:2.8
    container_name: pg_proxy
    volumes:
      - ./haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro
    ports:
      - "8008:5432"  # Note: if host port 5432 is occupied by Master, change to "XXXX:5432"
    networks:
      - mydb_streaming_net
    restart: always

networks:
  mydb_streaming_net:
    external: true
EOF
echo "[$(date '+%Y-%m-%d %H:%M:%S')]: Docker Compose file 'docker-compose-proxy.yml' created successfully."


# see start_env.md for instructions to start the environment
echo "[$(date '+%Y-%m-%d %H:%M:%S')]: All files created successfully. Please refer to 'start_env.md' for instructions to start the environment