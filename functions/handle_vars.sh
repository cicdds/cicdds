#!/usr/bin/env bash
# since: 2021-03-30
# author: gengxiankun <gengxiankun@126.com>
# 解析脚本输入参数

function handleExtra() {
	OLDIFS=$IFS;IFS=',';for var in $_extra; do
		export $var
	done;IFS=$OLDIFS
}

while getopts "f:w:e:" arg
do
    case $arg in
		f) _function="${OPTARG}" ;;
		w) _workspace="${OPTARG}" ;;
		e) _extra="${OPTARG}"; handleExtra ;;
        ?) echo "Invalid option: -$OPTARG"; exit 0 ;;
    esac
done

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
