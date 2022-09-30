#!/usr/bin/env bash
# since: 2021-09-30
# author: gengxiankun <gengxiankun@126.com>
# 插件列表
set -e

source ${DIR}/scripts/plugin/default.sh

varList=$(cat ${defaultConfigFile} | grep "# \[" | cut -d'[' -f 2 | cut -d']' -f 1)

echo -e "NAME VERSION TAP"
for var in $varList
do
    _getConfigVar $var
    echo -e "${var} ${!SCRIPT_VERSION} ${!SCRIPT_TAP}"
done
