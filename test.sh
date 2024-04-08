(set -e
cd ./tests
echo All tests ...
./test1.sh | diff /dev/stdin ./test1.out
./test2.sh | diff /dev/stdin ./test2.out
./test3.sh | diff /dev/stdin ./test3.out

) && echo OK || echo FAIL 1>&2