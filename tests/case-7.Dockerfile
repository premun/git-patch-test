# syntax=docker/dockerfile:1.3-labs

FROM vmr-base

WORKDIR /work/vmr
RUN rm -rf /work/vmr/* \
 && git add -A \
 && git commit -m "Prepare VMR contents"

COPY source-mappings.json /work/vmr/src/source-mappings.json

RUN git add -A \
 && git commit -m "Add source-mappings.json"

WORKDIR /work/individual-repo
RUN git submodule add /work/tmp/external-repo \
 && git add -A \
 && git commit -m "Add submodule" \
 && git submodule update --init --recursive \
 && set -x \
 && git -C /work/individual-repo/external-repo checkout `git -C /work/tmp/external-repo log --format=format:%H | tail -n 1` \
 && git add -A \
 && git commit -m "Checkout submodule to a specific commit" \
 && git -C /work/individual-repo/external-repo pull origin main \
 && git -C /work/individual-repo/external-repo checkout `git -C /work/tmp/external-repo log --format=format:%H | tail -n 2 | head -n 1` \
 && git add -A \
 && git commit -m "Update submodule to a different commit" \
 && cp -r /work/individual-repo /work/tmp/individual-repo


RUN <<EOF
cat <<ELF >> /root/.bashrc
function initialize() {
    darc vmr initialize --vmr /work/vmr/ --tmp /work/tmp/ --verbose individual-repo:$(git -C /work/tmp/external-repo log --format=format:%H | tail -n 1)
}
ELF
EOF
