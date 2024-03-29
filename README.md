# Amplify Central Resource Example

## Overview

There are a lot of automated processes interacting with Amplify Central to connect and manage a dataplane. These processes are referred to as the _agents_. These agents use the standard declarative configuration CRUD APIs of API Server.

This repo is a manual walk through of the steps involved.

- [01 - Environment Configuration](./01-env.md)
- [02 - Category](./02-category.md)
- [03 - API Service Creation](./03-apiservice.md)
- [04 - Assets](./04-asset.md)
- [05 - Products](./05-product.md)
- [06 - Marketplace](./06-marketplace.md)

For example github action:
[Action Central](https://github.com/bladedancer/action-central/blob/main/.github/workflows/resources.yml)