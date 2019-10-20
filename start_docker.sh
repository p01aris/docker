#!/bin/bash
docker run --runtime=nvidia -v /home/zl:/home --privileged=true -it nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04 bash
