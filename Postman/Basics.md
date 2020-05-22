# Basics

- Request Bearer Token
- interact with service

## Request Bearer token

### GET AAD Token

#### URI: 
    POST https://login.microsoftonline.com/:tenant_id/owuth2/token

#### URI Params: 
    tenant_id: found in the Azure ad properties 

#### BODY:
    grant_type: client_credentials
    client_id: appid 
    client_secret: thumprint or secret associated with client_id
    resource: https://management.azure.com

#### TESTS

    var json = JSON.parse(responseBody):
    tests("Get AAD Token") = !json.error && responseBody !== '' && responseBody !== '{}' && json.access_token !== '';
    postman.setEnvironmentVariable("bearerToken", json.access_token);

#### Get Data Lake Analytics Account

#### Create Job


###### References
- [Azure Data Lake Analytics REST API]('https://docs.microsoft.com/en-us/rest/api/datalakeanalytics/')
- [Job-Create]('https://docs.microsoft.com/en-us/rest/api/datalakeanalytics/job/create')
- [How to Execute Azure REST APIs with Postman]('https://youtu.be/ujzrq8Fg9Gc')