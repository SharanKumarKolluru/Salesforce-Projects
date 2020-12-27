global with sharing class PubProxyDataCallOut 
{
    @future(callout=true)
    // Method to hit Pub Proxy API and GET the Response
    global static void makePubProxyDataCallout()
    {
        // Creating an instance of HTTP class
        Http http = new Http();
        // Creating an instance of HTTPRequest class
        HttpRequest request = new HttpRequest();
        // Setting up the endpoint and method for the HTTP request
        request.setEndpoint('http://pubproxy.com/api/proxy');
        // Set the HTTP verb to GET.
        request.setMethod('GET');
        // Send the HTTP request and get the response.
        // The response is in JSON format.        
        HttpResponse response = http.send(request);
        System.debug(response.getBody());        
        
        /* The JSON Response Returned is the following Structure
        String JSONResponse = '{ "data": [ { "ipPort": "169.57.1.85:8123", 
        "ip": "169.57.1.85", "port": "8123", "country": "US", "last_checked": "2020-06-19 20:39:59", 
        "proxy_level": "elite", "type": "http", "speed": "9", 
        "support": { "https": 0, "get": 1, "post": 1, 
        "cookies": 1, "referer": null, "user_agent": 1, "google": 0 } } ], "count": 1 }' */
        
        // Checking the status code in the response
        if(response.getStatusCode() == 200) {
        
        List<Proxy_Server__c> upsertPubProxyList = new List<Proxy_Server__c>();
        
        Id proxyServerId = ProxyProviderInformation.identifyProvider('http://pubproxy.com/api/proxy');
        
        // Deserialize The JSON Response in to Map <String, Object>
        Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        
        // System.debug(results); - For Checking Map Results
        
        List<Object> proxyList = (List<Object>)results.get('data');
        
        // System.debug(proxyList); - Storing Map Response in to List<Object>
        
        for (Object proxyListObj : proxyList) {
            system.debug(proxyListObj);
            Map<string, Object> proxyAddress = (Map<string, Object>)proxyListObj;
            System.debug(proxyAddress.get('ip'));
            Proxy_Server__c proxyIpList = new Proxy_Server__c();
            proxyIpList.Name = (String)proxyAddress.get('country');
            proxyIpList.Country__c = (String)proxyAddress.get('country');
            proxyIpList.IP_Address__c = (String)proxyAddress.get('ip');
            proxyIpList.Port__c = (String)proxyAddress.get('port');
            proxyIpList.Last_Update__c = (String)proxyAddress.get('last_checked');
            proxyIpList.Proxy_Level__c = ((String)proxyAddress.get('proxy_level')).toUpperCase();
            proxyIpList.Type__c = ((String)proxyAddress.get('type')).toUpperCase();
           	proxyIpList.Provider__c = 'Pub Proxy';
            proxyIpList.Proxy_Provider__c = string.isNotBlank(proxyServerId)?proxyServerId:'';
            proxyIpList.IP__c = (String)proxyAddress.get('ip');
            proxyIpList.Base_URL__c = 'http://pubproxy.com/';
            
            upsertPubProxyList.add(proxyIpList);
        }
           
        INSERT upsertPubProxyList; 
        
        }
    }

}