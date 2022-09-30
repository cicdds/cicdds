#!/usr/bin/env bash
# since: 2021-04-10
# author: gengxiankun <gengxiankun@126.com>

source ${DIR}/functions/handle_config.sh
source ${DIR}/functions/handle_vars.sh
source ${DIR}/functions/handle_server.sh

function list() {
	serverList=$(cat ${DIR}/config | grep "#\[server:" | cut -d'[' -f 2 | cut -d']' -f 1)
	echo -e "NAME USER IP PORT"
	for server in $serverList; do
		server=${server#*:}
		getServerVar $server
		echo -e "$server ${!server_user} ${!server_ip} ${!server_port} "
	done
}


case $_type in
	list )
		list | column -t
		;;
	* )
		echo -e "$ERROR Unrecognized command of build: ${_type:-unkown}"; exit 1
		;;
esac
