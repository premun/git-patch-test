
Write-Host -ForeGroundColor Green "Test case #1"
docker run --rm -t vmr-case-1 /bin/bash /work/run-test.sh

Write-Host -ForeGroundColor Green "Test case #2"
docker run --rm -t vmr-case-2 /bin/bash /work/run-test.sh

Write-Host -ForeGroundColor Green "Test case #3"
docker run --rm -t vmr-case-3 /bin/bash /work/run-test.sh

Write-Host -ForeGroundColor Green "Test case #4"
docker run --rm -t vmr-case-4 /bin/bash /work/run-test.sh
