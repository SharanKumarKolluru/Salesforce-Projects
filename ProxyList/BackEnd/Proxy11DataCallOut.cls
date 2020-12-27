global class Proxy11DataCallOut 
{   
    @future(callout=true)
    // Method to hit Pub Proxy API and GET the Response
    global static void makeProxy11DataCallout() 
    {
        // Creating an instance of HTTP class
        Http httpProtocol = new Http();
        // Creating an instance of HTTPRequest class
		HttpRequest request = new HttpRequest();
        // Setting up the endpoint and method for the HTTP request
		String endpoint = 'https://proxy11.com/api/proxy.json?key=MTI5Ng.XtOqBQ.pdROud0hJbpolTGHRD3ACFtxE3M';
		request.setEndPoint(endpoint);
		// Set the HTTP verb to GET.
		request.setMethod('GET');
		// Send the HTTP request and get the response.
        // The response is in JSON format.
        HttpResponse response = httpProtocol.send(request);
        System.debug(response.getBody());
        
        /* The JSON Response Returned is the following Structure
        String JSONResponse = '{ "data": [ { "country": "United States", "country_code": "us", "createdAt": "Fri, 19 Jun 2020 20:02:31 GMT", 
		"google": 0, "ip": "162.159.242.51", "port": "80", "time": 0.09, "type": 0, "updatedAt": "Fri, 19 Jun 2020 20:02:31 GMT" }, 
		{ "country": "United States", "country_code": "us", "createdAt": "Fri, 19 Jun 2020 20:02:31 GMT", "google": 0, 
		"ip": "162.159.242.59", "port": "80", "time": 0.13, "type": 0, "updatedAt": "Fri, 19 Jun 2020 20:02:31 GMT" } ] }' */
        
        // Checking the status code in the response
        if(response.getStatusCode() == 200) {
		
      	List<Proxy_Server__c> upsertProxy11List = new List<Proxy_Server__c>();
        
        Id proxyServerId = ProxyProviderInformation.identifyProvider('https://proxy11.com/api/proxy.json?key=MTI5Ng.XtOqBQ.pdROud0hJbpolTGHRD3ACFtxE3M');
        
        //Deserialize The JSON Response in to Map <String, Object>
        Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        System.debug(results);
        
        List<Object> proxyList = (List<Object>)results.get('data');
        System.debug(proxyList);
        
        for (Object proxyListObj : proxyList) 
        {
        	system.debug(proxyListObj);
        	Map<string, Object> proxyAddress = (Map<string, Object>)proxyListObj;
        	System.debug(proxyAddress.get('ip'));
        	Proxy_Server__c proxyIpList = new Proxy_Server__c();
        	proxyIpList.Name = ((String)proxyAddress.get('country_code')).toUpperCase();
            proxyIpList.Country__c = (String)proxyAddress.get('country');
            proxyIpList.IP_Address__c = (String)proxyAddress.get('ip');
            proxyIpList.Port__c = (String)proxyAddress.get('port');
            proxyIpList.Last_Update__c = (String)proxyAddress.get('updatedAt');
            proxyIpList.Proxy_Level__c = (String.valueOf(proxyAddress.get('type')));
            proxyIpList.Provider__c = 'Proxy 11';
            proxyIpList.Proxy_Provider__c = string.isNotBlank(proxyServerId)?proxyServerId:'';
            ProxyIpList.IP__c = (String)proxyAddress.get('ip');
            proxyIpList.Base_URL__c = 'https://proxy11.com/';
            
            upsertProxy11List.add(proxyIpList);        
         
        	}
        	UPSERT upsertProxy11List; 
        }
    }
}