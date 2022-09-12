# syntax=docker/dockerfile:1.3-labs

FROM ubuntu:20.04

RUN apt-get update && apt-get install -y git tree wget
RUN git config --global user.email "prvysoky@microsoft.com" \
 && git config --global user.name "Premek Vysoky"

RUN <<EOF
cat <<ELF >> /root/.bashrc
function darc() {
    /work/arcade-services/.dotnet/dotnet /work/arcade-services/artifacts/bin/Microsoft.DotNet.Darc/Debug/net6.0/Microsoft.DotNet.Darc.dll $@
}
ELF
EOF

RUN mkdir -p /work/vmr \
 && mkdir -p /work/individual-repo \
 && mkdir -p /work/tmp/external-repo

WORKDIR /work/individual-repo
RUN mkdir included \
 && echo "Line 1\nLine 2\nLine 3\n" > included/A.txt

WORKDIR /work/vmr
RUN mkdir src \
 && cp -r /work/individual-repo src/individual-repo \
 && git init \
 && git add -A \
 && git commit -m "VMR initial commit"

WORKDIR /work/individual-repo
RUN mkdir ignored \
 && echo "Line 4\nLine 5\nLine 6\n" > ignored/B.txt \
 && git init \
 && git add -A \
 && git commit -m "individual repo initial commit" \
 && echo `git log --format="%H" -n 1` > ../from_commit # from_commit will hold the commit hash of the commit we will want to create patch from

WORKDIR /work/tmp/external-repo
RUN echo 'This repo will be referenced as a submodule' > a.txt \
 && git init \
 && git add -A \
 && git commit -m "Submodule initial commit" \
 && echo '!' >> a.txt \
 && git add -A \
 && git commit -m "Submodule commit with a change" \
 && echo '!' >> a.txt \
 && mkdir src && echo 'New file' >> src/b.txt \
 && git add -A \
 && git commit -m "Submodule commit with a new file"

WORKDIR /work

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT 1
ENV DOTNET_SKIP_FIRST_TIME_EXPERIENCE true
