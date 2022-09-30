#!/usr/bin/env bash
# since: 2021-04-10
# author: gengxiankun <gengxiankun@126.com>
# 全局动态配置

for item in `cat ${DIR}/resources/config`; do
	if [[ ${item:0:2} == "#[" ]]; then
		subject=${item:2:$(( ${#item} - 3 ))}
		continue
	fi
	if [[ $subject != "global" && $subject != "docker" ]]; then
		continue
	fi
	if [[ ! -e ${DIR}/config ]]; then
		cp ${DIR}/resources/config ${DIR}/config
	fi
	read -p "cicd $subject ${item%=*} [${item#*=}]: " val
	if [[ -n $val ]]; then
		sed -ri 's/(${item%=*}=)[^"]*/\1${val}/' ${DIR}/config
	fi
done;
