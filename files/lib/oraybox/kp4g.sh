#!/bin/sh

log()
{
	echo $*
	logger -t 'kp4g' "$*"
}

