#!/usr/bin/env bash
# since: 2021-04-07
# author: gengxiankun <gengxiankun@126.com>
# 通知驱动

function dingdingSend() {
	url="https://oapi.dingtalk.com/robot/send?access_token=${dingding_access_token}"
	header="Content-Type: application/json"
    curl --request POST "$url" -H "$header" --data-raw "$1"
}
