#!/bin/bash

axway auth login

axway central apply -f 1-env-staging.yaml
axway central apply -f 2-category-demo.yaml
axway central apply -f 3-stage-demo.yaml
axway central apply -f 4-accessrequestdefinition-demo.yaml
axway central apply -f 5-assetmappingtemplate-staging.yaml

axway central apply -f 6-apiservice-music.yaml
axway central apply -f 7-assetmapping-music.yaml

# Twiddle our thumbs waiting for asset creation
sleep 20
axway central apply -f 8-releasetag-music.yaml


axway central get environment,stage,category,apiservice,asset,assetrelease