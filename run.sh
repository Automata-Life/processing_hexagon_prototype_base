#! /bin/bash

../processing-java --sketch=`pwd` --output=`pwd`/tmp_output --run
rm -r tmp_output
