#!/bin/bash

axway auth login

axway central delete publishedproduct musicalinstruments -s e2d551f8-f908-4364-a14b-c0381afb87b9
axway central apply -f 99-clean-product-archive.yaml
axway central delete subscription gavin -y
axway central delete product musicalinstruments -y
axway central apply -f 99-clean-asset-deprecated.yaml
axway central apply -f 99-clean-asset-archive.yaml
axway central delete asset musicalinstruments -y
axway central delete environment resource-assets-env -y
