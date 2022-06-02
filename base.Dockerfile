FROM ubuntu:20.04

RUN apt-get update && apt-get install -y git tree
RUN git config --global user.email "prvysoky@microsoft.com"
RUN git config --global user.name "Premek Vysoky"

RUN mkdir -p /work/vmr && mkdir /work/individual-repo

WORKDIR /work/individual-repo
RUN mkdir included
RUN echo "Line 1\nLine 2\nLine 3\n" > included/A.txt

WORKDIR /work/vmr
RUN mkdir src
RUN cp -r /work/individual-repo src/individual-repo
RUN git init
RUN git add -A
RUN git commit -m "VMR initial commit"

WORKDIR /work/individual-repo
RUN mkdir ignored
RUN echo "Line 4\nLine 5\nLine 6\n" > ignored/B.txt
RUN git init
RUN git add -A
RUN git commit -m "individual repo initial commit"
RUN echo `git log --format="%H" -n 1` > ../from_commit

WORKDIR /work
