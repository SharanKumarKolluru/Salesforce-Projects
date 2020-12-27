@RestResource(urlMapping='/Proxy_Provider__c/*')
global with sharing class ProxyManager {
    @HttpGet
    global static Proxy_Provider__c getProxyProviderById(){
        RestRequest request = RestContext.request;
        // grab the proxyProviderId from the end of the URL
        String proxyProviderId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Proxy_Provider__c result =  [SELECT Id, Name, Proxy_Website__c, End_Point_URL__c FROM Proxy_Provider__c
                        WHERE Id = :proxyProviderId];
        return result;
    }
    @HttpPost
    global static ID createProxyProvider(String Name, String website,
        String endPointURL) {
        Proxy_Provider__c thisProxyProvider = new Proxy_Provider__c(
            Name = Name,
            Proxy_Website__c = website,
            End_Point_URL__c = endPointURL);
        insert thisProxyProvider;
        return thisProxyProvider.Id;
    } 
    @HttpDelete
    global static void deleteProxyProvider() {
        RestRequest request = RestContext.request;
        String proxyProviderId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Proxy_Provider__c thisProxyProvider = [SELECT Id FROM Proxy_Provider__c WHERE Id = :proxyProviderId];
        delete thisProxyProvider;
    }
    @HttpPut
    global static ID upsertProxyProvider(String Name, String website,
        String endPointURL, String id) {
        Proxy_Provider__c thisProxyProvider = new Proxy_Provider__c(
                Id = id,
                Name = Name,
                Proxy_Website__c = website,
                End_Point_URL__c = endPointURL);
        // Match Proxy Provider by Id, if present.
        // Otherwise, create new Proxy Provider.
        upsert thisProxyProvider;
        // Return the Proxy Provider ID.
        return thisProxyProvider.Id;
    }
    @HttpPatch
    global static ID updateProxyProviderFields() {
        RestRequest request = RestContext.request;
        String proxyProviderId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Proxy_Provider__c thisProxyProvider = [SELECT Id FROM Proxy_Provider__c WHERE Id = :proxyProviderId];
        // Deserialize the JSON string into name-value pairs
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        // Iterate through each parameter field and value
        for(String fieldName : params.keySet()) {
            // Set the field and value on the Proxy Provider sObject
            thisProxyProvider.put(fieldName, params.get(fieldName));
        }
        update thisProxyProvider;
        return thisProxyProvider.Id;
    }    

}