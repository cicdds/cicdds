#!/usr/bin/env bash
# since: 2021-09-30
# author: gengxiankun <gengxiankun@126.com>
# 移除插件
set -e

source ${DIR}/functions/handle_vars.sh
source ${DIR}/scripts/plugin/default.sh

# 插件管理
if [[ -z ${script} ]]; then return 1; fi
sed -i "" "/\[${script}\]/d" ${defaultConfigFile}
sed -i "" "/^${script}_url/d" ${defaultConfigFile}
sed -i "" "/^${script}_version/d" ${defaultConfigFile}
sed -i "" "/^${script}_tap/d" ${defaultConfigFile}

# 删除插件包
rm -rf ${DIR}/scripts/${script}
