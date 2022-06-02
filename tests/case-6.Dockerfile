# syntax=docker/dockerfile:1.3-labs

FROM vmr-base

# This test case renames an ignored file and should be a no-op
WORKDIR /work/individual-repo
RUN mv ignored/B.txt ignored/C.txt
RUN git add -A
RUN git commit -m "Renaming B.txt to C.txt"
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
