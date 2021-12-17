#!/bin/bash

axway auth login

axway central delete asset musicalinstruments -y
axway central delete stage demo -y
axway central delete environment staging -y
axway central delete category demo -y
axway central delete integration assetprovisioning -y