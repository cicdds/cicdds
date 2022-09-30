#!/usr/bin/env bash
# since: 2021-09-30
# author: gengxiankun <gengxiankun@126.com>
# 安装插件
set -e

source ${DIR}/functions/handle_vars.sh
source ${DIR}/functions/handle_json.sh

defaultConfigFile=${DIR}/resources/plugin

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

# 获取插件包
cd ${DIR}/resources && curl -# -o ${script_name}${script_cf} -OL ${script_url}

# 解压插件包
mkdir -vp ${DIR}/scripts/${script_name}
tar -zxvf ${script_name}${script_cf} -C ${DIR}/scripts/${script_name} --strip-components 1

# 清理缓存
rm -rf ${script_name}${script_cf}

# 插件管理
echo "# [${script_name}]" >> ${defaultConfigFile}
echo "${script_name}_url='${script_url}'" >> ${defaultConfigFile}
echo "${script_name}_version='${script_version}'" >> ${defaultConfigFile}
echo "${script_name}_tap=${tap}" >> ${defaultConfigFile}
