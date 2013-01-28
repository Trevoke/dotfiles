#!/bin/bash

find . -name '*.rb' > cscope.files
cscope -R -b
