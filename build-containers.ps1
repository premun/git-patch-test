# Use this script to build the containers, then run run-tests.ps1 to execute the tests

docker build --rm -t vmr-base -f base.Dockerfile .

docker build --rm -t vmr-case-1 -f tests/case-1.Dockerfile tests
docker build --rm -t vmr-case-2 -f tests/case-2.Dockerfile tests
docker build --rm -t vmr-case-3 -f tests/case-3.Dockerfile tests
docker build --rm -t vmr-case-4 -f tests/case-4.Dockerfile tests
docker build --rm -t vmr-case-5 -f tests/case-5.Dockerfile tests
docker build --rm -t vmr-case-6 -f tests/case-6.Dockerfile tests
