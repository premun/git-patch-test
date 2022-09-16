# syntax=docker/dockerfile:1.3-labs

FROM vmr-base

WORKDIR /work/vmr
RUN rm -rf /work/vmr/* \
 && git add -A \
 && git commit -m "Prepare VMR contents"

COPY source-mappings.json /work/vmr/src/source-mappings.json

RUN git add -A \
 && git commit -m "Add source-mappings.json"

RUN mkdir -p /work/tmp/external-repo
WORKDIR /work/tmp/external-repo
RUN echo 'This repo will be referenced as a submodule' > a.txt \
 && git init -b main \
 && git add -A \
 && git commit -m "Submodule initial commit" \
 \
 && echo '!' >> a.txt \
 && git add -A \
 && git commit -m "Submodule commit with a change" \
 \
 && echo '!' >> a.txt \
 && mkdir src && echo 'New file' >> src/b.txt \
 && git add -A \
 && git commit -m "Submodule commit with a new file" \
 \
 && echo '?' > src/c.txt \
 && rm a.txt src/b.txt \
 && git add -A \
 && git commit -m "Removed a.txt, src/b.txt and added src/c.txt" \
 \
 # Store commit hashes
 && git -C /work/tmp/external-repo log --format=format:%H > /work/external-repo-commits.txt

# Create a submodule, update where it points and commit it several times
WORKDIR /work/individual-repo
RUN set -x \
 && git -C /work/tmp/external-repo checkout `tail -n 1 /work/external-repo-commits.txt` \
 && git submodule add --name external1 -- /work/tmp/external-repo externals/external-repo \
 && git submodule update --init --recursive \
 && git add -A \
 && git commit -m "Add submodule" \
 \
 \
 && git -C /work/individual-repo/externals/external-repo checkout `tail -n 2 /work/external-repo-commits.txt | head -n 1` \
 && git add -A \
 && git commit -m "Checkout submodule to a specific commit" \
 \
 \
 && git -C /work/individual-repo/externals/external-repo pull origin main \
 && git -C /work/individual-repo/externals/external-repo checkout `tail -n 3 /work/external-repo-commits.txt | head -n 1` \
 && git add -A \
 && git commit -m "Update submodule to a different commit" \
 \
 \
 && git -C /work/individual-repo rm externals/external-repo \
 && git add -A \
 && git commit -m "Remove the submodule" \
 \
 \
 && git -C /work/tmp/external-repo checkout `tail -n 4 /work/external-repo-commits.txt | head -n 1` \
 && git submodule add --name external2 -- /work/tmp/external-repo externals/external-repo \
 && git submodule update --init --recursive \
 && git add -A \
 && git commit -m "Add a different submodule" \
 \
 \
 # Copy the repository to tmp (as it was already cloned to fool the CLI)
 && cp -r /work/individual-repo /work/tmp/individual-repo \
 && cp -r /work/tmp/external-repo /work/tmp/external1 \
 && cp -r /work/tmp/external-repo /work/tmp/external2 \
 && git -C /work/tmp/individual-repo remote add origin /work/individual-repo \
 && git -C /work/tmp/individual-repo fetch origin \
 && git -C /work/tmp/individual-repo branch -u origin/main

RUN <<EOF
cat <<ELF >> /root/.bashrc
function darc() {
    /work/arcade-services/.dotnet/dotnet /work/arcade-services/artifacts/bin/Microsoft.DotNet.Darc/Debug/net6.0/Microsoft.DotNet.Darc.dll "\$@"
}

function build-darc() {
    /work/arcade-services/.dotnet/dotnet build /work/arcade-services/src/Microsoft.DotNet.Darc/src/Darc/Microsoft.DotNet.Darc.csproj
}

function initialize() {
    darc vmr initialize --vmr /work/vmr --tmp /work/tmp --verbose individual-repo:\$(git -C /work/individual-repo log --format=format:%H | tail -n 1)
}

function initialize-debug() {
    darc vmr initialize --vmr /work/vmr --tmp /work/tmp --debug individual-repo:\$(git -C /work/individual-repo log --format=format:%H | tail -n 1)
}

function update() {
    darc vmr update --vmr /work/vmr --tmp /work/tmp --verbose individual-repo:\$(git -C /work/individual-repo log --format=format:%H | tail -n \$1 | head -n 1)
}

function update-debug() {
    darc vmr update --vmr /work/vmr --tmp /work/tmp --debug individual-repo:\$(git -C /work/individual-repo log --format=format:%H | tail -n \$1 | head -n 1)
}
ELF
EOF
