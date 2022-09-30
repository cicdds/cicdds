#!/usr/bin/env bash
# since: 2021-09-30
# author: gengxiankun <gengxiankun@126.com>
# 搜索插件
set -e

source ${DIR}/functions/handle_vars.sh
source ${DIR}/functions/handle_json.sh

if [[ ! -n ${script} ]]; then
    echo -e "$ERROR Parameter script is missing";exit 1
fi
tap=${tap:-cicdds}

data=`curl -fsl https://raw.githubusercontent.com/${tap}/cicdds-tap/main/${script}.json | sed  's/""/\n/g' | awk  '{{printf"%s",$0}}'`

# 获取插件属性
script_name=`getJsonValuesByAwk "${data}" "script" "" | sed 's/\"//g'`
script_url=`getJsonValuesByAwk "${data}" "url" "" | sed 's/\"//g'`
script_cf=`getJsonValuesByAwk "${data}" "cf" ".tar.gz" | sed 's/\"//g'`
script_run=`getJsonValuesByAwk "${data}" "run" "" | sed 's/\"//g'`
script_version=`getJsonValuesByAwk "${data}" "version" "latest" | sed 's/\"//g'`

echo -e "# ${script_name} \n - url: ${script_url} \n - cf: ${script_cf} \n - run: ${script_run} \n - version: ${script_version}"