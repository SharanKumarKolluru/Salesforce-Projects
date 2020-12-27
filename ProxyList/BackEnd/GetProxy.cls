public class GetProxy
{
	public String ip{get;set;}
    public String port{get;set;}
    public String protocol{get;set;}
    public String anonymity{get;set;}
    public String lastTested{get;set;}
    public Boolean allowsPost{get;set;}
    public Boolean allowsHttps{get;set;}
    public Boolean allowsCookies{get;set;}
    public Boolean allowsRefererHeader{get;set;}
    public Boolean allowsUserAgentHeader{get;set;}
	public Boolean allowsCustomHeaders{get;set;}
	public String country{get;set;}
	public String connectTime{get;set;}
	public String downloadSpeed{get;set;}
	public String secondsToFirstByte{get;set;}
	public String uptime{get;set;}
	
    
    public static GetProxy parse(String json){
		return (GetProxy) System.JSON.deserialize(json, GetProxy.class);
	}
}