#!/usr/bin/env bash
# since: 2021-03-30
# author: gengxiankun <gengxiankun@126.com>
# Docker Registry 授权

function dockerAuth() {
	if [[ ! -n ${docker_registry_user} || ! -n ${docker_registry_password} || ! -n ${docker_registry_url} ]]; then
		echo -e "$ERROR Docker authorization is missing parameters";exit 1
	fi
	docker login -u ${docker_registry_user} -p ${docker_registry_password} ${docker_registry_url}
}
