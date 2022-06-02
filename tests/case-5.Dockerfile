FROM vmr-base

# This test case renames an included file and should only cause a rename
WORKDIR /work/individual-repo
RUN mv included/A.txt included/C.txt
RUN git add -A
RUN git commit -m "Renaming A.txt to C.txt"
RUN echo `git log --format="%H" -n 1` > ../to_commit

WORKDIR /work

COPY run-test.sh /work
