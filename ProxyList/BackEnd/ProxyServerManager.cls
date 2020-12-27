@RestResource(urlMapping='/Proxy_Server__c/*')
global with sharing class ProxyServerManager {
    @HttpGet
    global static Proxy_Server__c getProxyServersById(){
        RestRequest request = RestContext.request;
        // grab the proxyServerId from the end of the URL
        String proxyServerId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Proxy_Server__c result =  [SELECT Id, Name, Country__c, IP_Address__c, Port__c, Type__c, Proxy_Level__c, 
                                   Last_Update__c, Proxy_Provider__c FROM Proxy_Server__c
                        WHERE Id = :proxyServerId];
        return result;
    }
    @HttpPost
    global static ID createProxyServer(String Name, String country,
        String ipAddress, String port, String protocoltype, String proxyLevel, String lastUpdate, String proxyProvider) {
        Proxy_Server__c thisProxyServer = new Proxy_Server__c(
            Name = Name,
            Country__c = country,
            IP_Address__c = ipAddress,
            Port__c = port, 
            Type__c = protocoltype, 
            Proxy_Level__c = proxyLevel, 
            Last_Update__c = lastUpdate, 
            Proxy_Provider__c = proxyProvider );
        insert thisProxyServer;
        return thisProxyServer.Id;
    } 
    @HttpDelete
    global static void deleteProxyServer() {
        RestRequest request = RestContext.request;
        String proxyServerId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Proxy_Server__c thisProxyServer = [SELECT Id FROM Proxy_Server__c WHERE Id = :proxyServerId];
        delete thisProxyServer;
    }
    @HttpPut
    global static ID upsertProxyServer(String Name, String country,
        String ipAddress, String port, String protocoltype, String proxyLevel, 
                                       String lastUpdate, String proxyProvider, String id) {
        Proxy_Server__c thisProxyServer = new Proxy_Server__c(
            Name = Name,
            Country__c = country,
            IP_Address__c = ipAddress,
            Port__c = port, 
            Type__c = protocoltype, 
            Proxy_Level__c = proxyLevel, 
            Last_Update__c = lastUpdate,
            Proxy_Provider__c = proxyProvider
           );
        // Match Proxy Server by Id, if present.
        // Otherwise, create new Proxy Server.
        upsert thisProxyServer;
        // Return the Proxy Server ID.
        return thisProxyServer.Id;
    }
    @HttpPatch
    global static ID updateProxyServerFields() {
        RestRequest request = RestContext.request;
        String proxyServerId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Proxy_Server__c thisProxyServer = [SELECT Id FROM Proxy_Server__c WHERE Id = :proxyServerId];
        // Deserialize the JSON string into name-value pairs
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        // Iterate through each parameter field and value
        for(String fieldName : params.keySet()) {
            // Set the field and value on the Proxy Server sObject
            thisProxyServer.put(fieldName, params.get(fieldName));
        }
        update thisProxyServer;
        return thisProxyServer.Id;
    }    

}