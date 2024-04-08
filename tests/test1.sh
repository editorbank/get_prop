
source ../prop.sh

echo "key1=value1 from stdin" | prop_value key1
echo "key2=value2 from stdin" | echo "-$( prop_value key2 )-"
echo "key3=value3 from stdin" | echo "-$( prop_from key3 /dev/stdin )-"

key4="value4 from env" env | grep key4
key5="value3 from env" echo "-$( env | grep key5 )-" # be empty

key6="value6 from env" prop_from key6 --env
key7="value7 from env" bash -c "source ../prop.sh ; prop_from key7 --env"
env key8="value8 from env" bash -c "source ../prop.sh ; prop_from key8 --env"
env key9="value9 from env" bash ../prop.sh prop_from key9 --env

export key10="value10 from env"
echo -`prop_from key10 --env`-
echo "-$( prop_from key10 --env )-"

prop_from key1 ./test.properties
