
source ./get_prop.sh

echo "key1=value1 from stdin" | get_prop_stdin key1
echo "key2=value2 from stdin" | echo "-$( get_prop_stdin key2 )-"
echo "key3=value3 from stdin" | echo "-$( get_prop_from key3 /dev/stdin )-"

key4="value4 from env" env | grep key4
key5="value3 from env" echo "-$( env | grep key5 )-" # be empty

key6="value6 from env" get_prop_from key6 env
key7="value7 from env" bash -c "source ./get_prop.sh ; get_prop_from key7 env"
env key8="value8 from env" bash -c "source ./get_prop.sh ; get_prop_from key8 env"
env key9="value9 from env" bash ./get_prop.sh get_prop_from key9 env

export key10="value10 from env"
echo -`get_prop_from key10 env`-
echo "-$( get_prop_from key10 env )-"

get_prop_from key1 ./test.properties
