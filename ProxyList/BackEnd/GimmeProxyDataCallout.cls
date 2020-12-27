global class GimmeProxyDataCallout 
{
	@future(callout=true)
    // Method to hit Pub Proxy API and GET the Response
    global static void makeGimmeProxyDataCallout() 
    {
        // Creating an instance of HTTP class
        Http httpProtocol = new Http();
        // Creating an instance of HTTPRequest class
		HttpRequest request = new HttpRequest();
        // Setting up the endpoint and method for the HTTP request
		String endpoint = 'https://gimmeproxy.com/api/getProxy';
		request.setEndPoint(endpoint);
		// Set the HTTP verb to GET.
		request.setMethod('GET');
		// Send the HTTP request and get the response.
        // The response is in JSON format.
        HttpResponse response = httpProtocol.send(request);
        System.debug(response.getBody());
        
        /* The JSON Response Returned is the following Structure
        String JSONResponse = '{ "_links": { "_self": "/proxy", "_parent": "/" }, "ip": "45.183.120.17", "port": 4145, 
		"protocol": "socks4", "anonymity": "high anonymity", "lastTested": "2020-06-19 16:12:04", "allowsRefererHeader": true, 
		"allowsUserAgentHeader": true, "allowsCustomHeaders": true, "allowsCookies": true, "allowsPost": false, 
		"allowsHttps": true, "country": "ZZ", "connectTime": "1.684", "downloadSpeed": "82.000", "secondsToFirstByte": "2.130", 
		"uptime": "23.397" }' */
        
        // Checking the status code in the response
        if(response.getStatusCode() == 200) {
        
        List<Proxy_Server__c> upsertGimmeProxyList = new List<Proxy_Server__c>();
        
        Id proxyServerId = ProxyProviderInformation.identifyProvider('https://gimmeproxy.com/api/getProxy');
        
        //Deserialize The JSON Response
        GimmeProxy proxyResults = (GimmeProxy)JSON.deserialize(response.getBody(), GimmeProxy.class);       
        system.debug(proxyResults);
        system.debug(proxyResults.country);
        
        Proxy_Server__c proxyIpList = new Proxy_Server__c();
        proxyIpList.Name = proxyResults.country;
        proxyIpList.IP_Address__c = proxyResults.ip;
        proxyIpList.Port__c = proxyResults.port;
        proxyIpList.Proxy_Level__c = (String.valueOf(proxyResults.anonymityLevel));
        proxyIpList.Type__c = (proxyResults.protocol).toUpperCase();
        proxyIpList.Provider__c = 'Gimme Proxy';
        proxyIpList.Proxy_Provider__c = string.isNotBlank(proxyServerId)?proxyServerId:'';
        proxyIpList.IP__c = proxyResults.ip;
        proxyIpList.Base_URL__c = 'https://gimmeproxy.com/';
        
        upsertGimmeProxyList.add(proxyIpList);
            
        INSERT upsertGimmeProxyList;
    	}
    }
}