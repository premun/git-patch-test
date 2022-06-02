# syntax=docker/dockerfile:1.3-labs

FROM vmr-base

# This test case renames an included file and should only cause a rename
WORKDIR /work/individual-repo
RUN mv included/A.txt included/C.txt
RUN git add -A
RUN git commit -m "Renaming A.txt to C.txt"
RUN echo `git log --format="%H" -n 1` > ../to_commit

WORKDIR /work

RUN <<EOF
cat <<ELF > /work/expected
/work/vmr
\`-- src
    \`-- individual-repo
        \`-- included
            \`-- C.txt

3 directories, 1 file
ELF
EOF

COPY run-test.sh /work
