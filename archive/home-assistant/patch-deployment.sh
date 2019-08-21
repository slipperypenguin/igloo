#!/bin/bash

set -e

kubectl patch deployment home-assistant -p \
  "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"
