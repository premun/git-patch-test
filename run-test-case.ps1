[CmdletBinding()]
param($Case)

Write-Host -ForeGroundColor Green "Individual repo before:"

docker run --rm -t vmr-base tree /work/individual-repo

Write-Host -ForeGroundColor Green "Individual repo after:"

docker run --rm -t vmr-case-$Case tree /work/individual-repo

Write-Host -ForeGroundColor Green "VMR before:"

docker run --rm -t vmr-case-$Case tree /work/vmr

Write-Host -ForeGroundColor Green "Running the test:"

docker run --rm -t vmr-case-$Case /bin/bash -c "./create-patch.sh && ./apply-patch.sh"
