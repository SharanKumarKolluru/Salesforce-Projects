public class ProxyProviderInformation {
    
    public static Id identifyProvider(String endPointURL)
    {
        Id TargetProvider = null;
        Map<Id, Proxy_Provider__c> providerList = new Map<Id, Proxy_Provider__c>([SELECT Id, Name, End_Point_URL__c, Proxy_Website__c FROM Proxy_Provider__c]);
        for(Proxy_Provider__c pro : providerList.values()){
            if(String.isNotBlank(endPointURL) && endPointURL == pro.End_Point_URL__c)
            {
                TargetProvider = pro.Id;
            }
        }
        
        return TargetProvider;
    }
    
}