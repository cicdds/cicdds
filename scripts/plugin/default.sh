#!/usr/bin/env bash
# since: 2021-09-30
# author: gengxiankun <gengxiankun@126.com>
set -e

defaultConfigFile=${DIR}/resources/plugin
# 初始化配置文件
if [[ ! -e ${defaultConfigFile} ]]; then
    touch ${defaultConfigFile}
    echo "#am.data" > ${defaultConfigFile}
fi

# 读取配置文件
source ${defaultConfigFile}

# 解析配置文件
function _getConfigVar() {
    SCRIPT_NAME=$1_name
    SCRIPT_VERSION=$1_version
    SCRIPT_TAP=$1_tap
}
