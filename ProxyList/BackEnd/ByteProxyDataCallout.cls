global class ByteProxyDataCallout 
{
    @future(callout=true)
    // Method to hit Pub Proxy API and GET the Response
    global static void makeByteProxyDataCallout() 
    {
        // Creating an instance of HTTP class
        Http httpProtocol = new Http();
        // Creating an instance of HTTPRequest class
        HttpRequest request = new HttpRequest();
        // Setting up the endpoint and method for the HTTP request
        String endpoint = 'https://byteproxies.com/api.php?key=free&amount=100&type=all&anonymity=all';
        request.setEndPoint(endpoint);
        // Set the HTTP verb to GET.
        request.setMethod('GET');
        // Send the HTTP request and get the response.
        // The response is in JSON format. 
        HttpResponse response = httpProtocol.send(request);
        System.debug(response.getBody());
        System.debug(response.getStatusCode());
        
        /* The JSON Response Returned is the following Structure
        String JSONResponse = '[ { "success": true, "response": { "ip": "5.58.58.209", "port": 8080, 
        "type": "http", "anonymity": "transparent", "country": "Ukraine", "country_code": "UA", "load": 3.55212, 
        "checked": "11:09:47 30.05.2020" } }, 
        { "success": true, "response": { "ip": "187.162.11.94", "port": 3128, "type": "http", "anonymity": "transparent", 
        "country": "Mexico", "country_code": "MX", "load": 3.30989, "checked": "11:09:13 30.05.2020" } } ]' */
        
        // Checking the status code in the response
        if(response.getStatusCode() == 200) {        
        
        Id proxyServerId = ProxyProviderInformation.identifyProvider('https://byteproxies.com/api.php?key=free&amount=100&type=all&anonymity=all');
        
        List<Proxy_Server__c> upsertByteProxyList = new List<Proxy_Server__c>();
            
        // Deserialize The JSON Response
        List<ByteProxy> proxyResults = ByteProxy.parse(response.getBody());
        
        System.debug(proxyResults);
        
        List <Proxy_Server__c> existingIps = new List <Proxy_Server__c> ([SELECT Id, Name, IP_Address__c FROM Proxy_Server__c]);
        Map <String, Proxy_Server__c> countryByIPMap = new Map <String, Proxy_Server__c>();
        
        //Search for existing IpAddress's in Salesforce for Name[IP Address] Match
        for (Proxy_Server__c exIP: existingIps) {
            countryByIPMap.put(exIP.IP_Address__c, exIP);
         }
        
        //Loops over the IP Results From API
        for (ByteProxy iPObj: proxyResults) 
        {
            System.debug(iPObj.Response.country);
            Proxy_Server__c proxyList = new Proxy_Server__c();
            if(countryByIPMap.containsKey(iPObj.Response.ip)){
                proxyList.Id = countryByIPMap.get(iPObj.Response.ip).Id;
            }
            proxyList.Name = iPObj.Response.country_code;
            proxyList.IP_Address__c = iPObj.Response.ip;
            proxyList.Port__c = (String.valueOf(iPObj.Response.port));
            proxyList.Type__c = (iPObj.Response.type).toUpperCase();
            proxyList.Proxy_Level__c = (iPObj.Response.anonymity).toUpperCase();
            proxyList.Country__c = iPObj.Response.country;
            proxyList.Last_Update__c = iPObj.Response.checked;
            proxyList.Provider__c = 'Byte Proxy';
            proxyList.Proxy_Provider__c = string.isNotBlank(proxyServerId)?proxyServerId:'';
            proxyList.IP__c = iPObj.Response.ip;
            proxyList.Base_URL__c = 'https://byteproxies.com/';
            
            upsertByteProxyList.add(proxyList);
        }
            UPSERT upsertByteProxyList;
        }
    }

}