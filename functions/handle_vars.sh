#!/usr/bin/env bash
# since: 2021-03-30
# author: gengxiankun <gengxiankun@126.com>
# 解析脚本输入参数

function handleExtra() {
	OLDIFS=$IFS;IFS=',';for var in $_extra; do
		export $var
	done;IFS=$OLDIFS
}

while getopts "t:w:e:" arg
do
    case $arg in
		t) _type="${OPTARG}" ;;
		w) _workspace="${OPTARG}" ;;
		e) _extra="${OPTARG}"; handleExtra ;;
        ?) echo "Invalid option: -$OPTARG"; exit 0 ;;
    esac
done

# 生成 Docker 镜像名称变量
# 规则：{私有仓库地址}/{Git仓库地址}:{环境变量}-latest
# 注意：目前统一构建 latest 版本
function generateDockerImageName() {
	if [[ ! -n ${docker_registry_url} || ! -n ${ci_project_path} || ! -n ${env} ]]; then
		echo -e "$ERROR docker_registry_url, ci_project_path or env does not exist, unable to generate docker image name";exit 1
	fi
	docker_image_name=${docker_registry_url}/${ci_project_path}:${env}-latest
}

# 生成 Docker 容器名称变量
function generateDockerContainerName() {
	if [[ ! -n ${ci_project_path} ]]; then
		echo -e "$ERROR ci_project_path does not exist, unable to generate docker container name";exit 1
	fi
	# 将 "/" 替换成 "_"
	docker_container_name=${ci_project_path//\//_}
}

# 生成 docker-compose server 名称变量
function generateDockerServerName() {
	if [[ ! -n ${_workspace} ]]; then
		echo -e "$ERROR workspace does not exist, unable to generate docker server name";exit 1
	fi
	docker_server_name=${_workspace}
}

# 生成运行时目录变量
function generateRuntimePath() {
	if [[ ! -n ${runtime_path_prefix} || ! -n ${ci_project_path} ]]; then
		echo -e "$ERROR runtime_path_prefix or ci_project_path does not exist, unable to generate runtime path";exit 1
	fi
	runtime_path=${runtime_path_prefix}${ci_project_path}
}

# 生成构建目录变量
function generateBuildPath() {
	if [[ ! -n ${build_path_prefix} || ! -n ${ci_project_path} ]]; then
		echo -e "$ERROR build_path_prefix or ci_project_path does not exist, unable to generate build path";exit 1
	fi
	build_path=${build_path_prefix}${ci_project_path}
}

# 生成 website 命名空间变量
function generateWebsiteNamespace() {
	if [[ ! -n ${website_path_prefix} || ! -n ${ci_project_path} ]]; then
		echo -e "$ERROR website_path_prefix or ci_project_path does not exist, unable to generate website namespace";exit 1
	fi
	website_namespace=${website_path_prefix}${ci_project_path%/*}
}

# 生成 website 目录变量
function generateWebsitePath() {
	if [[ ! -n ${website_path_prefix} || ! -n ${ci_project_path} ]]; then
		echo -e "$ERROR website_path_prefix or ci_project_path does not exist, unable to generate website path";exit 1
	fi
	website_path=${website_path_prefix}${ci_project_path}
}
