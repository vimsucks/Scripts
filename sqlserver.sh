#! /bin/sh
#
# sqlserver.sh
# Copyright (C) 2017 vimsucks <dev@vimsucks.com>
#
# Distributed under terms of the MIT license.
#

# also check https://www.daocloud.io/mirror#accelerator-doc if the pulling speed is too slow in china


#!/bin/bash
if ! which docker > /dev/null ; then
	echo ">> Please install docker first!!!"
	exit 1
fi

if [ "$(systemctl is-active docker)" = "inactive" ]; then
	echo ">> docker daemon is not running, starting up..."
	sudo systemctl start docker
else
	echo ">> docker daemon is already running"
fi

if [ -z "$(docker image ls | grep 'microsoft/mssql-server-linux')" ]; then
	echo ">> fetching latest microsoft/mssql-server-linux image"
	docker pull microsoft/mssql-server-linux
fi

if [ -z "$(docker ps | grep 'microsoft/mssql-server-linux')" ]; then
	echo ">> starting container..."
	if [ ! -d "$HOME/docker-mssql" ]; then
		echo ">> data folder not exists, new one locatd at $HOME/docker-mssql"
		mkdir $HOME/docker-mssql
	fi
	uuid=$(docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=2Y2spStnyf' -v $HOME/docker-mssql:/var/opt/mssql -p 1433:1433 -d microsoft/mssql-server-linux)
	echo ">> container uuid is $uuid"
	echo ">> wating for sql server, sleep 15 seconds"
	sleep 15s
else
	echo ">> container already started"
fi

if ! which sqlcmd > /dev/null ; then
	echo ">> Please install mssql-tools first!!!"
	exit 1
else
	sqlcmd -S localhost -U SA -P '2Y2spStnyf'
fi
