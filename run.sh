#!/bin/bash

. ./env.sh

axway central apply -f 01-env.yaml
axway central apply -f 01-env-credentialrequestdefinition.yaml
axway central apply -f 01-env-accessrequestdefinition.yaml

axway central apply -f 02-category.yaml

axway central apply -f 03-apiservice.yaml
axway central apply -f 03-apiservicerevision.yaml
axway central apply -f 03-apiserviceinstance.yaml

axway central apply -f 04-asset.yaml
axway central apply -f 04-stage.yaml
axway central apply -f 04-assetmapping.yaml
echo "Wait for mapping to complete"
sleep 20
axway central apply -f 04-assetrelease.yaml
echo "Wait for release to complete"
sleep 20


axway central apply -f 05-product.yaml
axway central apply -f 05-document-api-desc.yaml
axway central apply -f 05-document-description.yaml
axway central apply -f 05-productoverview.yaml
axway central apply -f 05-productrelease.yaml
echo "Wait for release to complete"
sleep 20

axway central apply -f 06-marketplace.yaml

# FOR NOW THE PRODUCT HAS TO BE RELEASED BEFORE PLAN CAN BE ADDED...DUBIOUS.
axway central apply -f 05-productplan.yaml
axway central apply -f 05-productplanunit.yaml
axway central apply -f 05-productplan-quota.yaml
axway central apply -f 05-productplan-active.yaml

echo "================================"
echo "Done."
echo "================================"

axway central get environment resource-assets-env
axway central get accessrequestdefinition,credentialrequestdefinition,apiservice,apiservicerevision,apiserviceinstance -s Environment/resource-assets-env

axway central get stage production
axway central get asset musicalinstruments
axway central get assetresource,assetmapping -s musicalinstruments
axway central get assetrelease musicalinstruments-1.0.0

axway central get product musicalinstruments

