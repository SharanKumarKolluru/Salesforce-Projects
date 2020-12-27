global class GetProxyDataCallout 
{
    @future(callout=true)
    // Method to hit Pub Proxy API and GET the Response
    global static void makeGetProxyDataCallout()
    {
        // Creating an instance of HTTP class
        Http http = new Http();
        // Creating an instance of HTTPRequest class
        HttpRequest request = new HttpRequest();
        // Setting up the endpoint and method for the HTTP request
        request.setEndpoint('https://api.getproxylist.com/proxy');
        // Set the HTTP verb to GET.
        request.setMethod('GET');
        // Send the HTTP request and get the response.
        // The response is in JSON format.
        HttpResponse response = http.send(request);
        System.debug(response);
        System.debug(response.getBody());
        
        /* The JSON Response Returned is the following Structure
        String JSONResponse = '{ "_links": { "_self": "/proxy", "_parent": "/" }, "ip": "45.183.120.17", "port": 4145, 
		"protocol": "socks4", "anonymity": "high anonymity", "lastTested": "2020-06-19 16:12:04", "allowsRefererHeader": true, 
		"allowsUserAgentHeader": true, "allowsCustomHeaders": true, "allowsCookies": true, "allowsPost": false, 
		"allowsHttps": true, "country": "ZZ", "connectTime": "1.684", "downloadSpeed": "82.000", "secondsToFirstByte": "2.130", 
		"uptime": "23.397" }' */
        
        // Checking the status code in the response
        if(response.getStatusCode() == 200) {
        
        List<Proxy_Server__c> upsertGetProxyList = new List<Proxy_Server__c>();
        
        Id proxyServerId = ProxyProviderInformation.identifyProvider('https://api.getproxylist.com/proxy');
        
        //Deserialize The JSON Response
        GetProxy proxyResults = (GetProxy)JSON.deserialize(response.getBody(), GetProxy.class);       
        system.debug(proxyResults);  
        
        /*GetProxy proxyResults = GetProxy.parse(response.getBody());
        system.debug(proxyResults);*/
       
        Proxy_Server__c proxyIpList = new Proxy_Server__c();
        proxyIpList.Name = proxyResults.country;
        proxyIpList.IP_Address__c = proxyResults.ip;
        proxyIpList.Port__c = proxyResults.port;
        proxyIpList.Last_Update__c = proxyResults.lastTested;
        proxyIpList.Proxy_Level__c = (proxyResults.anonymity).toUpperCase();
        proxyIpList.Type__c = (proxyResults.protocol).toUpperCase();
        proxyIpList.Provider__c = 'Get Proxy';
        proxyIpList.Proxy_Provider__c = string.isNotBlank(proxyServerId)?proxyServerId:'';
        proxyIpList.IP__c = proxyResults.ip;
        proxyIpList.Base_URL__c = 'https://getproxylist.com/';
            
        upsertGetProxyList.add(proxyIpList);  
        
        UPSERT upsertGetProxyList;
    }
  }

}