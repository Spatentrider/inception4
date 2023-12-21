NAME = inception

all:
	sudo mkdir -p /home/vbellucc/data/mariadb
	sudo mkdir -p /home/vbellucc/data/wordpress
	sudo docker-compose -f srcs/docker-compose.yaml up -d --build

# Target to run the container
up:
	sudo docker-compose -f srcs/docker-compose.yaml up

# Target to stop the container
stop:
	sudo docker-compose -f srcs/docker-compose.yaml down

# Target to clean up containers and volumes
clean:
	sudo docker-compose -f srcs/docker-compose.yaml down --volumes

# Target to clean up everything, including data and images
prune: clean
	sudo rm -rf /home/vbellucc/data/mariadb /home/vbellucc/data/wordpress
	sudo docker system prune -a

re: prune all

.PHONY: all stop clean prune re
