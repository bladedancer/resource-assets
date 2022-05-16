#!/bin/sh

export PLATFORM_ENV=prod
export CENTRAL_URL=https://apicentral.axway.com

axway --env $PLATFORM_ENV auth login 

axway central config set --platform=$PLATFORM_ENV
axway central config set --baseUrl=$CENTRAL_URL
