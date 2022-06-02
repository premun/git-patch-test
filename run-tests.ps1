# Use build-containers.ps1 first, then run this script to execute the tests

[CmdletBinding()]
param($Case)

function Run-Case {
    param ($case)

    Write-Host -ForeGroundColor Green "Test case #$case"
    docker run --rm -t vmr-case-$case /bin/bash /work/run-test.sh
    Write-Host
    Write-Host
}

if ($Case) {
    Run-Case $Case
    exit $LASTEXITCODE
}
else {
    for ($i = 1; $i -lt 7; $i++) {
        Run-Case $i
    }
}
