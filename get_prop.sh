function get_prop_stdin() {
  sed -n -r "s/^[ \t]*($1)[ \t]*=[ \t]*([\']([^\']+)[\']|[\"]([^\"]+)[\"]|([^ \t\'\"\r]+)|([^ \t\'\"\r]+([ \t]+[^ \t\'\"\r]+)+))[ \t\r]*$/\3\4\5\6/p"
}

function get_prop_from() {
  key=$1
  while [ -n "$2" ] ; do
    if [ "env" = "$2" ] ; then
      value=$( env | get_prop_stdin $key )
    else
      value=$( [ -r "$2" ] && cat "$2" | get_prop_stdin $key || true )
    fi
    [ -n "$value" ] && break || true
    shift
  done
  echo $value
}

function export_prop_from(){
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
     export $prefix$key$suffix="$( get_prop_from $key ${froms[@]} )"
  done
}

[ -z "$1" ] || get_prop_from $@
