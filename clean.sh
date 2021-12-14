#!/bin/bash

axway auth login

axway central delete asset/musicalinstruments
axway central delete stage/demo
axway central delete -f 1-env-staging.yaml
axway central delete -f 2-category-demo.yaml
