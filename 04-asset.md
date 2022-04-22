# Asset

Assets represent digital entities that can be managed across the organization. These may encapsulate APIs from managed dataplanes but can also represent any other digital entity (SDKs, Installer, etc).

## Stage

The details of an asset are contained in an AssetResource, a single Asset may represent the entire lifecycle of an entity. This is represented by the _Stage_ that the AssetResource is associated with.

For this example there is a single stage, _production_, that the AssetResource is associated with.

## Asset Mapping

The details of an asset, the AssetResource, can be created manually, however, if the content is derived from an APIService in a managed environment, the process can be automated using an AssetMapping.

The AssetMapping is a job that will copy the contents of the APIService into the Asset.

## Asset Release

An asset is a development resource not a discovered resource. It exists solely in Amplify Central and its lifecycle is internal to Amplify Central.

To mark an Asset as being ready for consumption by other processes, e.g. in a product, the Asset must be released. This is done by creating a release tag in the asset.