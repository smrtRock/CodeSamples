function New-AzureADAppID {
    Param
    (
        [Parameter(Mandatory = $false)]
        $subscriptionID,
        [Parameter(Mandatory = $true)]
        [pscredential]
        $Credential,
        [Parameter(Mandatory = $true)]
        $appName,
        [Parameter(Mandatory = $true)]
        $url,
        [Parameter(Mandatory = $true)]
        [securestring]
        $secret
    )
    Begin 
    {
        if ($null -eq $subscriptionID)
        {
            $value = Read-Host "Do you have any more than one subscriptions, provide the subscription id to associate this application with..." 
            $subscriptionID = $value; 
        }
        else {
                Write-Output "The default Subscription will be used"
        }
        }
    }
    Process {
        # Sign in to Azure.
        # Login-AzureRmAccount
        # If your Azure account is on a non-public cloud, make sure to specify the proper environment 
        # example for the German cloud:
        Login-AzureRmAccount -Credential $Credential

        # If you have multiple subscriptions, uncomment and set to the subscription you want to work with:
        # $subscriptionid =  "5a243c4b-c40a-41d4-85c9-5574124d8250"
        Set-AzureRmContext -subscriptionid $subscriptionID

        # Provide these values for your new Azure AD app:
        # $appName is the display name for your app, must be unique in your directory
        # $uri does not need to be a real URI
        # $secret is a password you create
        #$appName = "ManualFullFramework" # ManualCore
        #$uri = "http://localhost"
        #$secret = "somepass@word123$" | ConvertTo-SecureString -Force -AsPlainText

        # Create the Azure AD app
        $azureAdApplication = New-AzureRmADApplication -DisplayName $appName -HomePage $Uri -IdentifierUris $Uri -Password $secret

        # Create a Service Principal for the app
        $svcprincipal = New-AzureRmADServicePrincipal -ApplicationId $azureAdApplication.ApplicationId

        Read-Host -Prompt "Waiting for svcprincipal to complete this can take a few minutes press enter to ack..."

        # Assign the Contributor RBAC role to the service principal
        # If you get a PrincipalNotFound error: wait 15 seconds, then rerun the following until successful
        $roleassignment = New-AzureRmRoleAssignment -RoleDefinitionName Contributor -ServicePrincipalName $azureAdApplication.ApplicationId.Guid 

        # Display the values for your application 
        Write-Output "Save these values for using them in your application"
        Write-Output "Subscription ID:" (Get-AzureRmContext).Subscription.SubscriptionId
        Write-Output "Tenant ID:" (Get-AzureRmContext).Tenant.TenantId
        Write-Output "Application ID:" $azureAdApplication.ApplicationId.Guid
        Write-Output "Application Secret:" $secret
    }
}