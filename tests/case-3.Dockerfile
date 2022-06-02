# syntax=docker/dockerfile:1.3-labs

FROM vmr-base

# This test case moves a file from included to ignored directory
WORKDIR /work/individual-repo
RUN mv included/A.txt ignored/A.txt
RUN git add -A
RUN git commit -m "Moving A.txt from included/ to ignored/"
RUN echo `git log --format="%H" -n 1` > ../to_commit

WORKDIR /work

RUN <<EOF
cat <<ELF > /work/expected
/work/vmr

0 directories, 0 files
ELF
EOF

COPY run-test.sh /work
