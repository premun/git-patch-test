# Use this script to build the containers, then run run-tests.ps1 to execute the tests

docker build --rm -t vmr-base -f base.Dockerfile .

Set-Location tests
docker build --rm -t vmr-case-1 -f case-1.Dockerfile .
docker build --rm -t vmr-case-2 -f case-2.Dockerfile .
docker build --rm -t vmr-case-3 -f case-3.Dockerfile .
docker build --rm -t vmr-case-4 -f case-4.Dockerfile .
docker build --rm -t vmr-case-5 -f case-5.Dockerfile .
docker build --rm -t vmr-case-6 -f case-6.Dockerfile .
Set-Location ..
