global class DeleteProxyList {
    @future(callout=true)
    global static void deletePubProxyListFromDB()
    {
        // Get List of PubProxy Records
        List<Proxy_Server__c> pubProxyDel = [SELECT Id,Name,Proxy_Provider__c FROM Proxy_Server__c WHERE Proxy_Provider__r.Name = 'Pub Proxy'];
        // Check If PubProxy Records are NOT NULL 
        if(pubProxyDel != null)
        {
            System.debug(pubProxyDel);
            // IF PubProxy Records are NOT NULL, DELETE PubProxy Data
            DELETE pubProxyDel;
        }
    }
    
    @future(callout=true)
    global static void deleteProxy11ListFromDB()
    {
        // Get List of Proxy11 Records
        List<Proxy_Server__c> proxy11Del = [SELECT Id,Name,Proxy_Provider__c FROM Proxy_Server__c WHERE Proxy_Provider__r.Name = 'Proxy 11'];
        // Check If Proxy11 Records are NOT NULL
        if(proxy11Del != null)
        {
            System.debug(proxy11Del);
            // IF Proxy11 Records are NOT NULL, DELETE Proxy11 Data
            DELETE proxy11Del;
        }
    }
    
    @future(callout=true)
    global static void deleteGimmeListFromDB()
    {
        // Get List of GimmeProxy Records
        List<Proxy_Server__c> gimmeDel = [SELECT Id,Name,Proxy_Provider__c FROM Proxy_Server__c WHERE Proxy_Provider__r.Name = 'Gimme Proxy'];
        // Check If GimmeProxy Records are NOT NULL
        if(gimmeDel != null)
        {
            System.debug(gimmeDel );
            // IF Gimmeroxy Records are NOT NULL, DELETE GimmeProxy Data
            DELETE gimmeDel;
        }
    }
    
    @future(callout=true)
    global static void deleteGetProxyListFromDB()
    {
        // Get List of GetProxy Records
        List<Proxy_Server__c> getDel = [SELECT Id,Name,Proxy_Provider__c FROM Proxy_Server__c WHERE Proxy_Provider__r.Name = 'Get Proxy List'];
        // Check If GetProxy Records are NOT NULL
        if(getDel != null)
        {
            System.debug(getDel );
            // IF GetProxy Records are NOT NULL, DELETE GetProxy Data
            DELETE getDel;
        }
    }
    
    @future(callout=true)
    global static void deleteByteProxyListFromDB()
    {
        // Get List of ByteProxy Records
        List<Proxy_Server__c> byteDel = [SELECT Id,Name,Proxy_Provider__c FROM Proxy_Server__c WHERE Proxy_Provider__r.Name = 'Byte Proxy'];
        // Check If ByteProxy Records are NOT NULL
        if(byteDel != null)
        {
            System.debug(byteDel);
            // IF ByteProxy Records are NOT NULL, DELETE ByteProxy Data
            DELETE byteDel;
        }
    }

}