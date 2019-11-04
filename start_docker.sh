#!/bin/bash
docker run --runtime=nvidia -v /home/zl:/home --privileged=true -it cuda_lu bash
