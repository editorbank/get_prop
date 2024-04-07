set -e

source ./get_prop.sh

export_prop_from key8 key9 key10 key11 -f env ./test.properties ./test2.properties --prefix xxx_ --suffix _xxx
env | sort | grep xxx_
