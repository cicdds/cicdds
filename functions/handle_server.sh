#!/usr/bin/env bash
# since: 2021-04-01
# author: gengxiankun <gengxiankun@126.com>
# 通过私钥授权服务器

function serverAuthorization() {
	# 声明变量
	getServerVar

	# 私钥授权
	set +x; if [[ ! -n ${!server_key} ]]; then
		echo -e "$ERROR $1 private key does not exist!"; exit 1
	fi
	eval $(ssh-agent -s)
	echo "${!server_key}" | ssh-add -; set -x
}

# 声明变量
function getServerVar() {
	server_key=$1_key
	server_user=$1_user
	server_ip=$1_ip
	server_port=$1_port
}
