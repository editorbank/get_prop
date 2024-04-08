#!/bin/env bash

function prop_value(){
  sed -n -r "s/^[ \t]*($1)[ \t]*=[ \t]*([\']([^\']+)[\']|[\"]([^\"]+)[\"]|([^ \t\'\"\r]+)|([^ \t\'\"\r]+([ \t]+[^ \t\'\"\r]+)+))[ \t\r]*$/\3\4\5\6/p"
}

function prop_from(){
  key=$1
  while [ -n "$2" ] ; do
    if [ "env" = "$2" ] ; then
      value=$( env | prop_value $key )
    else
      value=$( [ -r "$2" ] && cat "$2" | prop_value $key || true )
    fi
    [ -n "$value" ] && break || true
    shift
  done
  echo $value
}

function export(){
  keys=()
  froms=()
  prefix=""
  suffix=""
  mode="-k"
  # parse params
  while [ -n "$1" ] ; do
    case "$1" in
      "--prefix" ) prefix="$2" ; shift ;;
      "--suffix" ) suffix="$2" ; shift ;;
      "-k" ) mode="-k" ;;
      "-f" ) mode="-f" ;;
      *)
        case $mode in
          "-k" ) keys+=( "$1" ) ;;
          "-f" ) froms+=( "$1" ) ;;
        esac
        ;;
    esac
    shift
  done
  # do export
  for key in "${keys[@]}" ; do
     export $prefix$key$suffix="$( prop_from $key ${froms[@]} )"
  done
}

function --help(){
  echo '
Shell script library for reading parameters from `*.properties` files.
Based on the `sed` command.

Use:
prop.sh <command> [ <arg1> [ ... ]]

List of available commands:'
declare -F |cut -d" " -f3|sort|xargs -i echo -e "\t{}"
}

[ -z "$1" ] || $@
