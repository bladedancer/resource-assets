# Environment Provisioning

## Environment

The environment is the representation of the dataplane in Amplify Central. It is the scope in which all the dataplane specific resources are contained.

Note the icon data needs to be base64 encoded

    base64 -w 0 imgs/demo.png > imgs/demo.png.base64

## Support For Provisioning Access

When provisioning access to an API on a dataplane there are 2 steps involved, granting permission to call the API in the gateway and provisioning a credential for the consumer.

## Access Request Definition

The access request definition defines the information to request from the consumer when provisioning access. For most dataplanes there is no additional information required so this is generally an empty schema.

## Credential Request Definition

The information required to provision a consumer in the IdP depends on the IdP and the credential type being provisioned. The credential request definition describes credential types that can be provisioned on this dataplane.
