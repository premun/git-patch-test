# syntax=docker/dockerfile:1.3-labs

FROM vmr-base

# This test case moves a file from ignored to included directory
WORKDIR /work/individual-repo
RUN mv ignored/B.txt included/B.txt
RUN git add -A
RUN git commit -m "Moving B.txt from ignored/ to included/"
RUN echo `git log --format="%H" -n 1` > ../to_commit

WORKDIR /work

RUN <<EOF
cat <<ELF > /work/expected
/work/vmr
\`-- src
    \`-- individual-repo
        \`-- included
            |-- A.txt
            \`-- B.txt

3 directories, 2 files
ELF
EOF

COPY run-test.sh /work
