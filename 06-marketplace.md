# Marketplace

The provisioning of marketplace happens outside of the declarative configuration. Hence the marketplace name is not known ahead of time. This will need to be retrieved, e.g.

    $ axway central get marketplace
    ✔ Resource(s) successfully retrieved

    NAME                                  DESCRIPTION  BASE PATH  AGE           TITLE                                 RESOURCE KIND  RESOURCE GROUP
    e2d551f8-f908-4364-a14b-c0381afb87b9                          2 months ago  e2d551f8-f908-4364-a14b-c0381afb87b9  Marketplace    catalog

## Subscription 

The interaction with Marketplace is not declarative. To consume a product in the marketplace open the product. Subscribe. Then create an application and provision access and a credential.

At this point there will be 3 resources in the environment:

    $ axway central get managedapplications,accessrequest,credential -s  resource-assets-env
    ✔ Resource(s) successfully retrieved

    NAME        AGE             TITLE       RESOURCE KIND       SCOPE KIND   SCOPE NAME           STATUS
    musicalapp  14 minutes ago  MusicalApp  ManagedApplication  Environment  resource-assets-env  Pending


    NAME                              AGE             TITLE                             RESOURCE KIND  SCOPE KIND   SCOPE NAME           RESOURCE GROUP
    8a2e803680438a0401805230e1660012  14 minutes ago  8a2e803680438a0401805230e1660012  AccessRequest  Environment  resource-assets-env  management


    NAME                              AGE            TITLE                             RESOURCE KIND  SCOPE KIND   SCOPE NAME           STATUS
    8a2e803680438a0401805239219f0013  5 minutes ago  8a2e803680438a0401805239219f0013  Credential     Environment  resource-assets-env  Pending


Normally there would be an agent watching for these resources and the processing would be automatic, the managed application would result in an application/usage plan/subscription in the gateway. The access request would add access for the API to that application. And the credential would provision the credential in the IdP, associate it with the application and return the secret to the marketplace.

## Faking the Application processing

Edit the managed applciation and set the status to active.

    group: management
    apiVersion: v1alpha1
    kind: ManagedApplication
    name: musicalapp
    title: MusicalApp
    metadata:
    scope:
        kind: Environment
        name: resource-assets-env
    spec:
    security:
        encryptionKey: |-
        -----BEGIN PUBLIC KEY-----
        MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAsMCabuTtCMrBTUgqVeaa
        2JVb34lvd4r8+4v3iL/0DQSphB8g09ie23YXXIn4VetVEhJq7sFbbTHNAMV6zdrt
        aS6M2m/Xg6Xi9mCCoYy/uQCJ40ahrt+vkiHqd0gP85ZJ636wTussxFGdWzwFnxzH
        O5pEk0GuBBgcEAPf6cyt/tFSoxKvZ54ekc0JG6dqyU1kPMM2fGPN+F1e/9zFtup2
        qTD6TCRRhItUGIjz4LppQCPQAz6VMTPHTmud2naAe/72Cw8zM1r0Iyeyo2HgXab4
        lsaloAYBtO29vYocUAJW4IIJ1R+vA4PkmsDGqHKuyK2DUgzWQqaIYie0991R0vWC
        dmjAcFoLiffOBt+9WqEb71QS7nog1yoi+AnxIf4U86540CMv4Z4TMbF2LVlVOT8z
        qihPJqTTkO1afDWqWqNsvNqsQVBOI5lEgt7Iafd+1MMkvp+jDqDl8eL6bKjAVFNm
        6HJbSJ4bHzrrutGt6oOrMyvpJINxtuLc0c3CB81kooBEPfMltxZQym1nCDfZckz5
        LBvaSrPMK+F+7vVfc/W9MoYWUgiOItCF70QsNIQ9y/olWYIQdeoVIPAhOIGwgy3A
        akEzSK2PNvUUKwu28+6vy9xaoV6yaprrznXqsINNy/D4UW6SSWh6Eui0IXsTwQAR
        P6k0EAZDXBwQYY7N5yIQub0CAwEAAQ==
        -----END PUBLIC KEY-----
        encryptionHash: SHA256
        encryptionAlgorithm: RSA-OAEP
    status:
    level: Success

The agent can also store dataplane metadata on the managed application to help traceability link the traffic to a specific application.

## Faking the Access Request processing

The access request would add access to the API to the application. Once done the status gets updated to success.

    group: management
    apiVersion: v1alpha1
    kind: AccessRequest
    name: 8a2e803680438a0401805230e1660012
    title: 8a2e803680438a0401805230e1660012
    metadata:
    scope:
        id: 8a2e8f46804c35b801805202e3992826
        kind: Environment
        name: resource-assets-env
    spec:
    data: {}
    apiServiceInstance: musicalinstruments-ars
    managedApplication: musicalapp
    status:
    level: Success

## Credential Processing

The agent is expected to provision a credential for the consumer in the IdP. This credential is granted access to the APIs via the Application in the gateway and the credential is returned to the consumer in marketplace. The agent is expected to encrypt the credential with the application public key.

### Get the public key

Replace _musicalapp_ with the specific application name.

    axway central get managedapplication musicalapp -s  resource-assets-env -o json | jq -r .spec.security.encryptionKey  > public-key.pem

To generate the encrypted content:

    echo superSecretKey | openssl pkeyutl -encrypt -pkeyopt rsa_padding_mode:oaep -pkeyopt rsa_oaep_md:sha256 -pubin -inkey public-key.pem  | base64 -w 0

Update the credential data subresource with this and set the status to success.

    group: management
    apiVersion: v1alpha1
    kind: Credential
    name: 8a2e803680438a0401805239219f0013
    title: 8a2e803680438a0401805239219f0013
    metadata:
    scope:
        kind: Environment
        name: resource-assets-env
    spec:
    data:
        Name: Gavin
    managedApplication: musicalapp
    credentialRequestDefinition: password
    data:
    password: lsRfW+qGUQOPqEUUFyjTwDJMwlQDPi5TodoKuSDwoCm2sCN353+JaImiYpIQZqi6s3zUmuMZBEjcl7h/Jp7e7jzn1/FXi9sHh5+YsZmFC1Nx6UM4424r219fKypiU2ZXVwhp6OkWMb8xKKoVOZlB+nefw5DAVyhjbtTdnj9rjFfO/lrnIC95aGldABCBG1Ak71ydLel8EKKQCysv8pDKG6Vi5b84tgDGRsR08Xv/O93RwzBAIfW/lorBQtqTkBzLFyr9WPQF3hfxirsbhkY84ceWEeQ12OHmd840DId4FDDAOZKXU2Iz2N95yXCj3xlskW3WfZQleqbjDyTMS8/E/NNnV5okETzsqFBGCV7nlOQ4PAB/cpXrR+DJcgbhm9ws5FnQL1aaoXoOj0vBJwJvorlP6wYS2nl+k/GzHFHw/i/gLojEFfSw8DS+0hr+m5vcInIDN9JL3d+m+PcpckTOyIOo04NpVgtLmfYBWwjGKXXiiI2r/fV9DwQfnWGF5dCA2NRiCTCW33+YZyVz/o58YPYSAYn1ZdvOz7/Qqn1OWaa2YeBarmnbfA+EtlzJGL5PI+d8ImBnXSmee5kT8i4/SXzpNs+hjmH5n91yrbSjRJus1tadqkLRoPCYsEBkColQPKMd63WG3x2wemstrHOeQOHwyZ0Xr1c7jrLQsdHsUG0=
    status:
    level: Success

