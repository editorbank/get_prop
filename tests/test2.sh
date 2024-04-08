set -e

source ../prop.sh

function prop(){
  prop_from $1 --env ./test.properties ./test2.properties /dev/stdin
}

function test1(){
  declare arr=(
    key1
    key2
    key3
    key4
    key5
    key6
    key7
    key8
    key9
    'key\.0'
    key10
    key11
  )
  ## now loop through the above array
  for i in "${arr[@]}"

  do
     echo "-$( prop $i )-"
  done
}

echo "key11=value from stdin" | key10="value from Environment variable"  test1 