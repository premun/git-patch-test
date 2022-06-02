#!/bin/bash

set -e

echo "Applying patch.."
git -C /work/vmr apply /work/patch || echo "Patch failed!"
