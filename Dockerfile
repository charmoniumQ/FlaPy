FROM registry.hub.docker.com/library/python:3.10.1-bullseye

WORKDIR /workdir

# Input: like run_execution_container.sh
# Ouput: write results to mounted dir

# TODO build flapy in this container (multi-stage dockerfile)

# -- INSTALL FLAPY
COPY clone_and_run_tests.sh .
COPY dist/flapy-0.2.0-py3-none-any.whl .
RUN ["pip", "install", "flapy-0.2.0-py3-none-any.whl"]

RUN apt-get update && apt-get install -y git libfaketime build-essential
RUN git clone https://github.com/charmoniumQ/deterministic && env -C deterministic gcc -O2 -fPIC -shared -o deterministic_random_preload.so deterministic_random_preload.c

ENTRYPOINT ["./clone_and_run_tests.sh"]
