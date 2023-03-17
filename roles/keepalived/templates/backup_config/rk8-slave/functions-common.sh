#!/usr/bash

# check if process with name $1 exists
check_process() {
	local _p="${1}"
	[[ -z "${_p}" ]] && return 1
	# this is cheaper than pidof and ps
	killall -0 "${_p}" > /dev/null 2>&1
	return $?
}

# check if process with pid from file $1 exists
check_pid_file() {
	local _p="$1"
	[[ -z "${_p}" ]] && return 1
	[[ -f "${_p}" ]] || return 1
	kill -0 `head -n 1 "${_p}"` > /dev/null 2>&1
	return $?
}

# return 0 if $1 is a valid listened port
check_listen_port() {
	local _p="$1"
	[[ -z "${_p}" ]] && return 1
	local _res=`netstat -nalp | grep "[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}:${_p} "`
	[[ $? -le 0 ]] && [[ -n "${_res}" ]] && return 0
	return 1
}

exit_err() {
	_msg="${1:-Unknown}"
	echo `date`"${0}.${_svc} ${_msg}" >> "${LOG}"
	exit ${2:-1}
}
