FROM vmr-base

WORKDIR /work/individual-repo
RUN mv ignored/B.txt included/B.txt
RUN git add -A
RUN git commit -m "Moving B.txt from ignored/ to included/"
RUN echo `git log --format="%H" -n 1` > ../to_commit

WORKDIR /work
