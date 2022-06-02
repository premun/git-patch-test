FROM vmr-base

WORKDIR /work/individual-repo
RUN mv included/A.txt ignored/A.txt
RUN git add -A
RUN git commit -m "Moving A.txt from included/ to ignored/"
RUN echo `git log --format="%H" -n 1` > ../to_commit

WORKDIR /work

COPY create-patch.sh /work/run-test.sh
