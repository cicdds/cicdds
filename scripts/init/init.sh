#!/usr/bin/env bash
# since: 2021-09-30
# author: gengxiankun <gengxiankun@126.com>
# 构建项目
set -e

source ${DIR}/functions/handle_vars.sh

# setp1 创建脚本目录
if [[ ! -n ${script} ]]; then
    echo -e "$ERROR Script is missing parameters";exit 1
fi
mkdir -vp ${DIR}/scripts/${script}

# setp2 初始化脚本
commands=('build' 'deploy' 'release')
for command in ${commands[*]};do
    echo -e "#!/usr/bin/env bash" >> ${DIR}/scripts/${script}/${command}.sh
    echo -e "# since: ${since}" >> ${DIR}/scripts/${script}/${command}.sh
    echo -e "# author: ${author} <${email}>" >> ${DIR}/scripts/${script}/${command}.sh
    echo -e "set -e" >> ${DIR}/scripts/${script}/${command}.sh
    echo -e "" >> ${DIR}/scripts/${script}/${command}.sh
    echo -e "source \${DIR}/functions/handle_vars.sh" >> ${DIR}/scripts/${script}/${command}.sh
    echo -e "" >> ${DIR}/scripts/${script}/${command}.sh
    chmod +x ${DIR}/scripts/${script}/${command}.sh
done
