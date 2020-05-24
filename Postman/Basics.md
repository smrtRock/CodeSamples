# Basics

- Request Bearer Token
- interact with service

## Request Bearer token

### GET AAD Token

#### URI

    POST https://login.microsoftonline.com/:tenantid/owuth2/token`

#### URI Params

    tenant_id: found in the Azure ad properties 

#### BODY

```
    tenantID: adccdb0e-0c48-49c8-967b-482a191886ac
    subscriptionID: 5a243c4b-c40a-41d4-85c9-5574124d8250
    clientSecret: 0Vw.xFPFYXn2P._14NO4wxn-Yd32045-~t
    clientID: 5627a0a2-0aeb-471e-b09a-0551b0425578
    resource: https://management.azure.com
    grantType: client_credentials


    grant_type: client_credentials
    client_id: appid
    client_secret: thumprint or secret associated with client_id
    resource: https://management.azure.com
```

#### TESTS

    var json = JSON.parse(responseBody):
    tests["Get AAD Token"] = !json.error && responseBody !== '' && responseBody !== '{}' && json.access_token !== '';
    postman.setEnvironmentVariable("bearerToken", json.access_token);

#### Get Data Lake Analytics Account

#### Create Job

##### References

- [Azure Data Lake Analytics REST API]('https://docs.microsoft.com/en-us/rest/api/datalakeanalytics/')
- [Job-Create]('https://docs.microsoft.com/en-us/rest/api/datalakeanalytics/job/create')
- [How to Execute Azure REST APIs with Postman]('https://youtu.be/ujzrq8Fg9Gc')