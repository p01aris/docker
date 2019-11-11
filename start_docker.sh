#!/bin/bash
docker run --runtime=nvidia -v /home/zl:/home -p 8888:8888 --privileged=true -it cuda_lu bash
