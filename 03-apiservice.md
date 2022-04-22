# API Service

An API Service represents a consumable API. The API may have multiple revisions (APIServiceRevision) and may have multiple deployed instances (APIServiceInstances).

For this example it's a simple scenario with a single API service revision and instance.

The service being used is [Musical Instruments](https://musicalinstruments.axway.com/apidoc/swagger.json).

## API Service Revision

The API Service Revision contains the API definition. Amplify Central supports any definition. The specification is passed as a base64 encoded content and the type is identified, in this case as oas2.

## API Service Instance

This is the location where the API is hosted. It also defines the credential request definition and access request definition for this instance. These need to be set if the API is productized and credential provisioning in Marketplace is required.