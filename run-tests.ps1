# Use build-containers.ps1 first, then run this script to execute the tests

Write-Host -ForeGroundColor Green "Test case #1"
Write-Host
docker run --rm -t vmr-case-1 /bin/bash /work/run-test.sh

Write-Host
Write-Host
Write-Host -ForeGroundColor Green "Test case #2"
Write-Host
docker run --rm -t vmr-case-2 /bin/bash /work/run-test.sh

Write-Host
Write-Host
Write-Host -ForeGroundColor Green "Test case #3"
Write-Host
docker run --rm -t vmr-case-3 /bin/bash /work/run-test.sh

Write-Host
Write-Host
Write-Host -ForeGroundColor Green "Test case #4"
Write-Host
docker run --rm -t vmr-case-4 /bin/bash /work/run-test.sh

Write-Host
Write-Host
Write-Host -ForeGroundColor Green "Test case #5"
Write-Host
docker run --rm -t vmr-case-5 /bin/bash /work/run-test.sh

Write-Host
Write-Host
Write-Host -ForeGroundColor Green "Test case #6"
Write-Host
docker run --rm -t vmr-case-6 /bin/bash /work/run-test.sh
