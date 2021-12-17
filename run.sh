#!/bin/bash

axway auth login

axway central apply -f 01-env-staging.yaml
axway central apply -f 02-category-demo.yaml
axway central apply -f 03-stage-demo.yaml
axway central apply -f 04-accessrequestdefinition-demo.yaml
axway central apply -f 05-resourcehook.yaml
axway central apply -f 06-assetmappingtemplate-staging.yaml

axway central apply -f 07-apiservice-music.yaml
axway central apply -f 08-assetmapping-music.yaml

# Twiddle our thumbs waiting for asset creation
sleep 20
axway central apply -f 09-releasetag-music.yaml


axway central get environment,stage,category,apiservice,asset,assetrelease