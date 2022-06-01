[CmdletBinding()]
param($Case)

Write-Host -ForeGroundColor Green "State before:"

docker run --rm -t vmr-base tree /work/individual-repo

Write-Host -ForeGroundColor Green "State after:"

docker run --rm -t vmr-case-$Case tree /work/individual-repo

Write-Host -ForeGroundColor Green "Running the test:"

docker run --rm -t vmr-case-$Case /bin/bash -c "./create-patch.sh && ./apply-patch.sh"
