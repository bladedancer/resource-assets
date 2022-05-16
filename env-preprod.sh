#!/bin/sh

export PLATFORM_ENV=staging
export CENTRAL_URL=https://gmatthews.dev.ampc.axwaytest.net

axway --env $PLATFORM_ENV auth login 

axway central config set --platform=$PLATFORM_ENV
axway central config set --baseUrl=$CENTRAL_URL
